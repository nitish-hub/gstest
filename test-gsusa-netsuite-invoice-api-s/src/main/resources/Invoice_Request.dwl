%dw 2.0
output application/java
---
{
       externalId: vars.invoiceData.externalId,
       entity: {
             internalId: vars.invoiceData.entity.internalId,
             externalId: vars.invoiceData.entity.externalId
       },
       tranDate: ((vars.invoiceData.tranDate as Date {format: 'MM-dd-yyyy'}) ++ "T00:00:00") as LocalDateTime,
       dueDate: ((vars.invoiceData.dueDate as Date {format: 'MM-dd-yyyy'}) ++ "T00:00:00") as LocalDateTime,
       email:vars.invoiceData.email,
       account: {
             internalId: vars.invoiceData.account.internalId,
             externalId: vars.invoiceData.account.externalId
       },
       itemList: {
             item: vars.invoiceData.itemList.item map ( item , indexOfItem ) -> {
                    item: {
                           internalId: item.item.internalId
                    },
                    description: item.description,
                    line: item.line,
                    quantity: item.quantity,
                    rate: item.rate,
                    isTaxable: item.isTaxable,
                    customFieldList: {
                           customField: item.customFieldList.customField map (customField, indexOfCustomField) ->
                           if (customField.scriptId contains ("date")) 
                           {
                                 value: ((customField.value as Date {format: 'MM-dd-yyyy'}) ++ "T00:00:00") as LocalDateTime ,
                                 scriptId: customField.scriptId
                           } as Object {class: "org.mule.module.netsuite.extension.api.DateCustomFieldRef"}
                           else if (customField.scriptId == 'cseg_vol2_hybris_id' or customField.scriptId == 'cseg_vol2_gsusa_id' or customField.scriptId == 'custcol_vol2_council' or customField.scriptId == 'custcol_vol2_council' or customField.scriptId == 'custcol_vol2_financial_aid_source')
                           {
                                 value:  { externalId : customField.value //if (customField.scriptId == 'cseg_vol2_hybris_id' ) vars.addRecOut.addRecOutput.cseg_vol2_hybris_id else if (customField.scriptId == 'cseg_vol2_gsusa_id' ) vars.addRecOut.addRecOutput.cseg_vol2_gsusa_id else customField.value 
                                 } as Object {class: "org.mule.module.netsuite.extension.api.ListOrRecordRef"} ,
                                 scriptId: customField.scriptId
                           } as Object {class: "org.mule.module.netsuite.extension.api.SelectCustomFieldRef"}          
                           else
                           {
                                 scriptId: customField.scriptId,
                                 value: customField.value
                           }      as Object {class: "org.mule.module.netsuite.extension.api.StringCustomFieldRef"}
                    }as Object {class: "org.mule.module.netsuite.extension.api.CustomFieldList"}
             }},
             customFieldList: {
                    customField: vars.invoiceData.customFieldList.customField map ( customField , indexOfCustomField ) -> 
                    if (customField.scriptId contains ("cseg")) 
                    {
                           scriptId: customField.scriptId,
                           value: {
                                   externalId : customField.value //if (customField.scriptId == "cseg_vol2_hybris_id" ) vars.addRecOut.addRecOutput.cseg_vol2_hybris_id else vars.addRecOut.addRecOutput.cseg_vol2_gsusa_id,
                             } as Object {class: "org.mule.module.netsuite.extension.api.ListOrRecordRef"}
                    } as Object {class: "org.mule.module.netsuite.extension.api.SelectCustomFieldRef"}
                    else
                           {
                                 value: customField.value,
                                 scriptId: customField.scriptId
                           } as Object {class: "org.mule.module.netsuite.extension.api.StringCustomFieldRef"}                                           
             } as Object {class: "org.mule.module.netsuite.extension.api.CustomFieldList"}
}