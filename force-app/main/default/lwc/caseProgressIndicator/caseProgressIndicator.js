import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { api, LightningElement, wire } from 'lwc';
import CASE_OBJECT from '@salesforce/schema/Case';
import STATUS_FIELD from '@salesforce/schema/Case.Status';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';

export default class CaseProgressIndicator extends LightningElement {
    statusOptions;
    @api recordId;
    caseStatusValue;

//1.get the picklist values for the case status

@wire(getObjectInfo,{
    objectApiName: CASE_OBJECT
})
objectInfo;

@wire(getPicklistValues, {
    recordTypeId: "$ObjectInfo.data.defaultRecordTypeId",
    fieldApiName: STATUS_FIELD
})
picklistFunction({data, error}){
    if(data){
        console.log(data);
        this.statusOptions = data.values;
    } else if(error){
        console.log("Error while fectching picklist" , error);
    }
}

//get current value of case status

@wire(getRecord, {
    recordId:"$recordId",
    fields: [STATUS_FIELD]})
    getRecordOutput({data, error}){
        if(data){
            console.log(data);
            this.currentStatusValue = getFieldValue(data, STATUS_FIELD);
        }else if(error){
            console.log("Error while fetching record", error);
        }
    }
}