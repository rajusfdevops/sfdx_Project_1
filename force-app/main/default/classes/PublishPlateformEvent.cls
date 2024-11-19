public with sharing class PublishPlateformEvent {
    
    Public static void  PlateformEvent_1(){
        
        List<Order_Detail__e> orderDetailListEvent= new  List<Order_Detail__e>();
        orderDetailListEvent.add(new Order_Detail__e(Order_Number__c = 'ORD-10001',Generate_Invoice__c=true));
        orderDetailListEvent.add(new Order_Detail__e(Order_Number__c = 'ORD-10002',Generate_Invoice__c=false));
        orderDetailListEvent.add(new Order_Detail__e(Order_Number__c = 'ORD-10003',Generate_Invoice__c=true));
        orderDetailListEvent.add(new Order_Detail__e(Order_Number__c = 'ORD-10004',Generate_Invoice__c=false));
        orderDetailListEvent.add(new Order_Detail__e(Order_Number__c = 'ORD-10005',Generate_Invoice__c=false));
        
        PublishPlatformEventCallback callbackInstance=new PublishPlatformEventCallback();
        
        List<Database.saveResult> eventList = EventBus.publish(orderDetailListEvent, callbackInstance);
        for(Database.saveResult eventItem : eventList){
            if(eventItem.isSuccess()){
                System.debug('Plateform Event Published Successfully');
            }else {
                List<Database.error> errList=  eventItem.getErrors();
                for(Database.error errorDetail : errList){
                    System.debug('Error Details '+ errorDetail.getMessage());
                }
            }
        }
    }
    
}