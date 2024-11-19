trigger CaseTrigger on Case (before delete) {
    /*
    if(Trigger.isBefore && Trigger.isDelete){
        CaseTriggerHandler.preventDeletionOfClosedCases(Trigger.old);
        
    }*/
    
    switch on Trigger.OperationType{
        when BEFORE_DELETE{
            CaseTriggerHandler.preventDeletionOfClosedCases(Trigger.old);
        }
    }
}