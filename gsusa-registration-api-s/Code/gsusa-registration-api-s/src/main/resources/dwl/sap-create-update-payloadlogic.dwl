%dw 2.0
//import modules::globalCustomFunctions as GlobalFunc
output application/json
---
{
(
 "Data": //Initial Signup Process for Parent,Signing up a Girl with unknown Troop,IRG or individually registered Girl Payload 
 {
  "registerInfo": [
    {
      "firstName": vars["input"].Register[0].firstName,
      "lastName": vars["input"].Register[0].lastName,
      "contactInfo": [
        {
	      "crmGlobalCustomerID": vars["input"].Register[0].crmGlobalCustomerID,
          "customer": vars["input"].Register[0].customer,
          "firstName": vars["input"].Register[0].firstName,
          "lastName": vars["input"].Register[0].lastName,
          "phoneNumber": vars["input"].Register[0].phoneNumber,
          "email": vars["input"].Register[0].email,
          "contactType": "INITIALSIGNUP",
          "registrationSequence": vars["input"].Register[0].registrationSequence
        }
      ]
    }
  ]
 }
) if (vars["input"].Register[0].contactType == 'INITIALSIGNUP'),
(
 "Data": //Add Registration Details of Girl to Parent, Add Registration to self (IRG),Add Registration for a Girl with unknown Troop Payload
 {
   "registerInfo": [
    {
      "contactInfo": [
        {
          "crmGlobalCustomerID": vars["input"].Register[0].crmGlobalCustomerID,
          "gsCustomerUid": vars["input"].Register[0].gsCustomerUid,
          "customer": vars["input"].Register[0].customer,
          "firstName": vars["input"].Register[0].firstName,
          "lastName": vars["input"].Register[0].lastName,
          "gradeType": vars["input"].Register[0].grade,
          "assignedTroop": vars["input"].Register[0].assignedTroop,
          "assignedTroopStatus": vars["input"].Register[0].assignedTroopStatus,
          "assignedCouncil": vars["input"].Register[0].assignedCouncil,
          "assignedCouncilStatus": vars["input"].Register[0].assignedCouncilStatus,
          "phoneNumber": vars["input"].Register[0].phoneNumber,
          "email": vars["input"].Register[0].email,
          "contactType": vars["input"].Register[0].contactType,
          "birthDate": vars["input"].Register[0].birthDate as Date {format: 'yyyy-MM-dd'} as String {format: 'MM-dd-yyyy'},
          "genderType": upper(vars["input"].Register[0].gender),
		  "alumni": vars["input"].Register[0].alumni, 
          "registrationSequence": vars["input"].Register[0].registrationSequence, 
          "productCode": vars["input"].Register[0].productCode, 
          "bundleCode":"",
          "paymentMode":vars["input"].Register[0].paymentMode
        }
      ]
    }
  ]
 
 }
) if ( vars["input"].Register[0].contactType == 'GIRL' and vars["input"].Register[0].addcaregiver == 'N'),
(
 "Data": //Add Registration Details of Volunteer,Registration to self (Parent Account) Payload
 {
  "registerInfo": [
    {
      "contactInfo": [
        {
          "crmGlobalCustomerID": vars["input"].Register[0].crmGlobalCustomerID, 
          "gsCustomerUid": vars["input"].Register[0].gsCustomerUid,
          "customer": vars["input"].Register[0].customer,
          "firstName": vars["input"].Register[0].firstName,
          "lastName": vars["input"].Register[0].lastName,
          "gradeType": vars["input"].Register[0].grade,
          "assignedTroop": vars["input"].Register[0].assignedTroop,
          "assignedTroopStatus": vars["input"].Register[0].assignedTroopStatus,
          "assignedCouncil": vars["input"].Register[0].assignedCouncil,
          "assignedCouncilStatus": vars["input"].Register[0].assignedCouncilStatus,
          "phoneNumber": vars["input"].Register[0].phoneNumber,
          "email": vars["input"].Register[0].email,
          "contactType": vars["input"].Register[0].contactType,
          "volunteerPosition": vars["input"].Register[0].volunteerPosition, 
          "volunteerStatus": vars["input"].Register[0].volunteerStatus, 
          "birthDate": vars["input"].Register[0].birthDate as Date {format: 'yyyy-MM-dd'} as String {format: 'MM-dd-yyyy'},
          "genderType": upper(vars["input"].Register[0].gender),
		  "alumni": vars["input"].Register[0].alumni,
	 //     "caregiverType": vars["input"].Register[0].caregiverType, 
     //     "caregiverLevel": vars["input"].Register[0].caregiverLevel,  
          "relatedCRMGlobalCustomerID": vars["input"].Register[0].relatedCRMGlobalCustomerID, 
          "registrationSequence": vars["input"].Register[0].registrationSequence, 
          "productCode": vars["input"].Register[0].productCode,
          "bundleCode":""
        }
      ]
    }
  ]
 }
) if (vars["input"].Register[0].contactType == 'VOLUNTEER'),
(
 "Data": //Registration of Girl with Multiple Caregivers  
 {
    
 "registerInfo":[{
		
		"contactInfo":
		[{
          "crmGlobalCustomerID": vars["input"].Register[0].crmGlobalCustomerID,
          "gsCustomerUid": vars["input"].Register[0].gsCustomerUid,
          "customer": vars["input"].Register[0].customer,
          "firstName": vars["input"].Register[0].firstName,
          "lastName": vars["input"].Register[0].lastName,
          "gradeType": vars["input"].Register[0].grade,
          "assignedTroop": vars["input"].Register[0].assignedTroop,
          "assignedTroopStatus": vars["input"].Register[0].assignedTroopStatus,
          "assignedCouncil": vars["input"].Register[0].assignedCouncil,
          "assignedCouncilStatus": vars["input"].Register[0].assignedCouncilStatus,
          "phoneNumber": vars["input"].Register[0].phoneNumber,
          "email": vars["input"].Register[0].email,
          "contactType": vars["input"].Register[0].contactType,
          "birthDate": vars["input"].Register[0].birthDate as Date {format: 'yyyy-MM-dd'} as String {format: 'MM-dd-yyyy'},
          "genderType": upper(vars["input"].Register[0].gender),
		  "alumni": vars["input"].Register[0].alumni, 
          "registrationSequence": vars["input"].Register[0].registrationSequence, 
          "productCode": vars["input"].Register[0].productCode, 
          "bundleCode":"",
          "paymentMode":vars["input"].Register[0].paymentMode
		}]
 }] ++
  (
	payload.Caregivers[0 to sizeOf(payload.Caregivers.registrationSequence) -1] map
    {
        "firstName": $.firstName,
        "lastName": $.lastName,
      "contactInfo": [
          {
          "crmGlobalCustomerID": $.crmGlobalCustomerID,
          "customer": $.customer,
          "firstName": $.firstName,
          "lastName": $.lastName,
          "phoneNumber": $.phoneNumber,
          "email": $.email,
          "contactType": $.contactType,
          "genderType": upper($.gender), 
          "caregiverType": $.caregiverType,
          "caregiverLevel": $.caregiverLevel,
          "relatedCRMGlobalCustomerID": $.relatedCRMGlobalCustomerID,
          "registrationSequence": $.registrationSequence
         }
       ]
    }
  )
 }
) if ( vars["input"].Register[0].contactType == 'GIRL' and vars["input"].Register[0].addcaregiver == 'Y')
} 