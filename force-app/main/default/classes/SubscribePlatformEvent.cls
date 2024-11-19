public with sharing class SubscribePlatformEvent {
    
    public static void afterInsert(List<Order_Detail__e> orderDetailPlatformEventList){
        List<task> taskList = new List<task>();
        
        User adminUser=[Select id From User Where Username ='rajukumarsfdevops@gmail.com'];
        
        for(Order_Detail__e orderDetail: orderDetailPlatformEventList){
            Task taskDetail = new Task();
            taskDetail.Subject = 'Platform Event Subscribed Using Trigger';
            taskDetail.Description = orderDetail.Order_Number__c;
            taskDetail.OwnerId=adminUser.Id;
            taskDetail.ActivityDate=date.today();
            taskList.add(taskDetail);
            
        }
        if(!taskList.isEmpty()){
            try{
               insert taskList; 
            }catch(Exception ex){
                System.debug('Tasl creation failed ' + ex.getMessage());
            }
        }
    }
}