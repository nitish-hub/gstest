%dw 2.0
output application/json
---
{
(
 "Data": //Initial Signup Process for Parent,Signing up a Girl with unknown Troop,IRG or individually registered Girl Payload 
 { 
     "Register":[
      {
         "crmGlobalCustomerID": vars["sfdcResponse"].Response[0].crmGlobalId[0],
         "firstName": vars["DataPayload"].Register[0].firstName,
         "lastName": vars["DataPayload"].Register[0].lastName,
         "customer": vars["DataPayload"].Register[0].customer,
         "phoneNumber": vars["DataPayload"].Register[0].phoneNumber,
         "email": vars["DataPayload"].Register[0].email,
         "contactType": "INITIALSIGNUP",
         "registrationSequence": vars["DataPayload"].Register[0].registrationSequence
      }
   ]
 }
) if (vars["DataPayload"].Register[0].contactType == 'INITIALSIGNUP'),
(
 "Data": //Add Registration Details of Girl to Parent, Add Registration to self (IRG),Add Registration for a Girl with unknown Troop Payload
 { 
     "Register":[
      { 
		 "crmGlobalCustomerID": vars["sfdcResponse"].Response[0].crmGlobalId[0],
		 "parentcrmGlobalCustomerID" : vars["DataPayload"].Register[0].parentcrmGlobalCustomerID,
		 "addcaregiver":vars["DataPayload"].Register[0].addcaregiver,
		 "accountType":vars["DataPayload"].Register[0].accountType,
         "recordTypeName": vars["DataPayload"].Register[0].recordTypeName,
		 "registrationSequence": vars["DataPayload"].Register[0].registrationSequence, 
		 "contactType": vars["DataPayload"].Register[0].contactType,
		 "firstName": vars["DataPayload"].Register[0].firstName,
         "lastName": vars["DataPayload"].Register[0].lastName,
		 "genderType": vars["DataPayload"].Register[0].gender,
		 "grade": vars["DataPayload"].Register[0].grade,
		 "email": vars["DataPayload"].Register[0].email,
		 "birthDate": vars["DataPayload"].Register[0].birthDate,
		 "mobilePhone": vars["DataPayload"].Register[0].phoneNumber,
		 "phoneNumber": vars["DataPayload"].Register[0].phoneNumber,
		 "gsCustomerUid": vars["DataPayload"].Register[0].gsCustomerUid,
         "assignedTroop": vars["DataPayload"].Register[0].assignedTroop,
         "assignedTroopStatus": vars["DataPayload"].Register[0].assignedTroopStatus,
         "assignedCouncil": vars["DataPayload"].Register[0].assignedCouncil,
         "assignedCouncilStatus": vars["DataPayload"].Register[0].assignedCouncilStatus,
		 "customer": vars["DataPayload"].Register[0].customer,
		 "paymentType":"",
         "alumni": vars["DataPayload"].Register[0].alumni,    
         "productCode": vars["DataPayload"].Register[0].productCode, 
         "bundleCode":"",
         "paymentMode":vars["DataPayload"].Register[0].paymentMode 
		 
      }
   ]
 
 }
) if ( vars["DataPayload"].Register[0].contactType == 'GIRL' and vars["DataPayload"].Register[0].addcaregiver == 'N'),
(
 "Data": //Registration of Girl with Multiple Caregivers  
 {
      "Register":[
        { 
		 "crmGlobalCustomerID": vars["sfdcResponse"].Response[0].crmGlobalId[0],
		 "parentcrmGlobalCustomerID" : vars["DataPayload"].Register[0].parentcrmGlobalCustomerID,
		 "addcaregiver":vars["DataPayload"].Register[0].addcaregiver,
		 "accountType":vars["DataPayload"].Register[0].accountType,
         "recordTypeName": vars["DataPayload"].Register[0].recordTypeName,
		 "registrationSequence": vars["DataPayload"].Register[0].registrationSequence, 
		 "contactType": vars["DataPayload"].Register[0].contactType,
		 "firstName": vars["DataPayload"].Register[0].firstName,
         "lastName": vars["DataPayload"].Register[0].lastName,
		 "genderType": vars["DataPayload"].Register[0].gender,
		 "grade": vars["DataPayload"].Register[0].grade,
		 "email": vars["DataPayload"].Register[0].email,
		 "birthDate": vars["DataPayload"].Register[0].birthDate,
		 "mobilePhone": vars["DataPayload"].Register[0].phoneNumber,
		 "phoneNumber": vars["DataPayload"].Register[0].phoneNumber,
		 "gsCustomerUid": vars["DataPayload"].Register[0].gsCustomerUid,
         "assignedTroop": vars["DataPayload"].Register[0].assignedTroop,
         "assignedTroopStatus": vars["DataPayload"].Register[0].assignedTroopStatus,
         "assignedCouncil": vars["DataPayload"].Register[0].assignedCouncil,
         "assignedCouncilStatus": vars["DataPayload"].Register[0].assignedCouncilStatus,
		 "customer": vars["DataPayload"].Register[0].customer,
		 "paymentType":"",
         "alumni": vars["DataPayload"].Register[0].alumni,    
         "productCode": vars["DataPayload"].Register[0].productCode, 
         "bundleCode":"",
         "paymentMode":vars["DataPayload"].Register[0].paymentMode 
		 
        }
    ]
   ,
	 "Caregivers":  (vars["DataPayload"].Caregivers default []) map(object,index) -> using (id = object.registrationSequence) {
	 	
    (( vars["sfdcResponse"].ResponseCG default []) filter ($.*sequenceId contains id)  map (responseObject) -> 
    	{
     	  "crmGlobalCustomerID": responseObject.crmGlobalId[0],
		  "parentcrmGlobalCustomerID" :object.parentcrmGlobalCustomerID,
          "customer": object.customer,
          "firstName": object.firstName,
          "lastName": object.lastName,
          "phoneNumber": object.phoneNumber,
          "email": object.email,
          "contactType": object.contactType,
          "gender": object.gender,
          "caregiverType": object.caregiverType,
          "caregiverLevel": object.caregiverLevel,
          "relatedCRMGlobalCustomerID": vars["sfdcResponse"].Response[0].crmGlobalId[0],
          "registrationSequence": object.registrationSequence,
		  "accountType":object.accountType,
		  "RecordTypeName": object.RecordTypeName,
		  "birthDate" :object.birthDate,
		  "role": object.role 
     })
    
    }  
 }
) if ( vars["DataPayload"].Register[0].contactType == 'GIRL' and vars["DataPayload"].Register[0].addcaregiver == 'Y')
} 