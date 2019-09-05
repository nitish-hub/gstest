%dw 2.0
output application/json
---
{
(
 "Data": //Initial Parent Register
{
	"personAccounts": [
		{
	        "GlobalId": vars["input"].Register[0].crmGlobalCustomerID,
			"FirstName": vars["input"].Register[0].firstName,
			"LastName": vars["input"].Register[0].lastName,
			"HomePhone": vars["input"].Register[0].phoneNumber ,
			"PreferredPhone": "PersonHomePhone" ,
			"HomeEmail": vars["input"].Register[0].email,
			"PreferredEmail": "Home_Email__pc",
			"Role": vars["input"].Register[0].role,
			"SequenceId": vars["input"].Register[0].registrationSequence 
	    }]
}
) if (vars["input"].Register[0].accountType == 'Person' and vars["input"].Register[0].contactType == 'INITIALSIGNUP'),
(
 "Data": // Registration of a Girl to Parent 
{
	"personAccounts": [
		{
          	"FirstName": vars["input"].Register[0].firstName,
            "LastName": vars["input"].Register[0].lastName,
            "BirthDate": vars["input"].Register[0].birthDate,
			"HomePhone": vars["input"].Register[0].phoneNumber,
			"Street": vars["input"].Register[0].mailingAddress.mailingStreet ,
			"City": vars["input"].Register[0].mailingAddress.mailingcity,
			"StateCode": vars["input"].Register[0].mailingAddress.mailingstate ,
			"PostalCode": vars["input"].Register[0].mailingAddress.mailingpostalCode ,
			"CountryCode": vars["input"].Register[0].mailingAddress.mailingcountry ,
			"MobilePhone": vars["input"].Register[0].phoneNumber,
			"OtherPhone": vars["input"].Register[0].phoneNumber,
			"PreferredPhone": "PersonHomePhone",
			"NickName": vars["input"].Register[0].nickname,
			"MaidenName": null,
			"PhoneOptIn": false,
			"TextOptIn": false,
			"PhotoOptIn": false,
			"EmailOptIn": true,
			"HomeEmail": vars["input"].Register[0].email,
			"WorkEmail": null,
			"OtherEmail": null,
			"PreferredEmail": "Home_Email__pc",
			"Race": vars["input"].Register[0].race,
			"Ethnicity": vars["input"].Register[0].ethnicity,
			"Gender":    vars["input"].Register[0].gender,
			"MaritalStatus": vars["input"].Register[0].maritalStatus,
			"University": vars["input"].Register[0].university,
			"Grade": vars["input"].Register[0].grade,
			"Role": vars["input"].Register[0].role,
			"SequenceId": vars["input"].Register[0].registrationSequence,
			"Type": vars["input"].Register[0].recordTypeName,
			"Active": true,
			"MinorsPrimaryContact": false,
			"Affiliations": [
				{
					"AccountId": vars["input"].Register[0].parentcrmGlobalCustomerID,
					"Active": true,
                    "Type": vars["input"].Register[0].recordTypeName,
			        "MinorsPrimaryContact": false
				}
			]		
	    }
    ]
}
) if ((vars["input"].Register[0].accountType == 'Person' and vars["input"].Register[0].contactType == 'GIRL') and vars["input"].Register[0].addcaregiver == 'N'),
(
 "Data": //Registration of Girl with Multiple Caregivers  
 {
    
 "personAccounts":[
        {
 
          "FirstName": vars["input"].Register[0].firstName,
          "LastName": vars["input"].Register[0].lastName,
          "BirthDate": vars["input"].Register[0].birthDate,
		  "HomePhone": vars["input"].Register[0].phoneNumber,
		  "PreferredPhone": "PersonHomePhone",
		  "HomeEmail": vars["input"].Register[0].email,
		  "PreferredEmail": "Home_Email__pc",
		  "Gender":  vars["input"].Register[0].gender,
		  "Grade": vars["input"].Register[0].grade,
		  "Role": vars["input"].Register[0].role,
		  "SequenceId": vars["input"].Register[0].registrationSequence,
		  "Type": vars["input"].Register[0].recordTypeName,
		  "Active": true,
		  "MinorsPrimaryContact": false,
		  "Affiliations": []
	    }
   ] ++
(
      payload.Caregivers[0 to sizeOf(payload.Caregivers.registrationSequence) -2] filter (sizeOf(payload.Caregivers.registrationSequence) != 1) map
          {
  
	   	    "FirstName": $.firstName,
		    "LastName": $.lastName,
		    "HomePhone": $.phoneNumber,
		    "PreferredPhone": "PersonHomePhone",
            "HomeEmail": $.email,
            "PreferredEmail": "Home_Email__pc",
	        "Role": $.role,
		    "Active": true,
            "Type": $.recordTypeName, 
            "MinorsPrimaryContact": false,
		    "SequenceId": $.registrationSequence,
		    "Affiliations": []
          }
) ++
(
      payload.Caregivers[-1 to sizeOf(payload.Caregivers.registrationSequence) -1] map
          {

	   	    "FirstName": $.firstName,
		    "LastName": $.lastName,
		    "HomePhone": $.phoneNumber,
		    "PreferredPhone": "PersonHomePhone",
            "HomeEmail": $.email,
            "PreferredEmail": "Home_Email__pc",
	        "Role": $.role,
		    "Active": true,
            "Type": $.recordTypeName, 
            "MinorsPrimaryContact": false,
		    "SequenceId": $.registrationSequence,
		    "Affiliations": [
   				{
					"AccountId": vars["input"].Register[0].registrationSequence,
					"Active": true,
                    "Type": "Girl",
			        "MinorsPrimaryContact": false
				}
			  ] ++ 
			  (
                   payload.Caregivers[0 to sizeOf(payload.Caregivers.registrationSequence) -2] filter (sizeOf(payload.Caregivers.registrationSequence)>1) map
                 {
  
					"AccountId": $.registrationSequence,
					"Active": true,
                    "Type": $.recordTypeName,
			        "MinorsPrimaryContact": false
                 }
              )
			  
          }
) 
}
) if ( ( vars["input"].Register[0].accountType == 'Person' and vars["input"].Register[0].contactType == 'GIRL' ) and vars["input"].Register[0].addcaregiver == 'Y'),
(
	
 "Data": //Business Account Registration 
{
   "businessAccounts": [
	{
		"SequenceId": vars["input"].Register[0].registrationSequence,
		"Type": "Account",
		"fields": {
            "Name": vars["input"].Register[0].businessAccountName,
            "Phone": vars["input"].Register[0].phoneNumber,
            "Active__c": true,
            "BillingStreet": vars["input"].Register[0].billingAddress.billingStreet,
            "BillingState": vars["input"].Register[0].billingAddress.billingState,
            "BillingPostalCode": vars["input"].Register[0].billingAddress.billingPostalCode,
            "BillingCity": vars["input"].Register[0].billingAddress.billingCity,
            "BillingCountry": vars["input"].Register[0].billingAddress.billingCountry,
            "Preferred_Billing_County__c": vars["input"].Register[0].preferredBillingCounty,
            "Common_Name__c": "Test",
            "Grade__c": vars["input"].Register[0].grade,
            "Program_Grade_Level__c": vars["input"].Register[0].programGradeLevel,
            "Website": vars["input"].Register[0].website,
            "RecordTypeId": vars["input"].Register[0].recordTypeName
        }
	}
  ] 
 
 }
 
	/*
	"businessAccounts": [
		{		
			"GlobalId": vars["input"].Register[0].crmGlobalCustomerID,
			"Name": vars["input"].Register[0].businessAccountName,
            "Phone": vars["input"].Register[0].phoneNumber,
            "Active": true,
            "Street": vars["input"].Register[0].billingAddress.billingStreet,
            "StateCode": vars["input"].Register[0].billingAddress.billingState,
            "PostalCode": vars["input"].Register[0].billingAddress.billingPostalCode,
            "City": vars["input"].Register[0].billingAddress.billingCity,
            "CountryCode": vars["input"].Register[0].billingAddress.billingCountry,
            "County": vars["input"].Register[0].preferredBillingCounty,
            "CommonName": "Test",
            "Grade": vars["input"].Register[0].grade,
            "ProgramGrade": vars["input"].Register[0].programGradeLevel,
            "Website": vars["input"].Register[0].website,
            "SequenceId": vars["input"].Register[0].registrationSequence,
            "Type": vars["input"].Register[0].recordTypeName
                        
	    }]
	    */
	    
 
	  	    
) if (vars["input"].Register[0].accountType == 'Business' and vars["input"].Register[0].contactType == 'INITIALSIGNUP')
} 