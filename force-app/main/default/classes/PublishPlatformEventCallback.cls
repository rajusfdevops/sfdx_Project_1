public with sharing class PublishPlatformEventCallback implements EventBus.EventPublishSuccessCallback, EventBus.EventPublishFailureCallback {
    
    public void onSuccess(EventBus.SuccessResult result){
         List<String> EventUUIDList = result.getEventUuids();
         insertTask(EventUUIDList,true);
    }
    
    public void onFailure(EventBus.FailureResult result){
         List<String> EventUUIDList = result.getEventUuids();
         insertTask(EventUUIDList,false);
    }
    
    public void insertTask(List<String> EventUUIDList, Boolean isSuccess){
        String EventUUIDString = '';
        for(String EventUUID : EventUUIDList){
            EventUUIDString = EventUUIDString + EventUUID + '';
            
        }
        Task taskDetail = new Task();
        if(isSuccess==true){
            //If plateform Event published successfully
            taskDetail.Subject ='Plaform Event Published Successfully';
            taskDetail.Description='Total platform Events Publish Success' +EventUUIDList.size() + 'List of Event UUID Published Success' +EventUUIDString;
        }else{
            //If platform Event Publish Failed
            taskDetail.Subject ='Plaform Event Published Failed';
            taskDetail.Description='Total platform Events Publish Failed' +EventUUIDList.size() + 'List of Event UUID Published Failed' +EventUUIDString;
        }
        taskDetail.ActivityDate = Date.today();
        User userDetail=[Select id From User Where username='rajukumarsfdevops@gmail.com'];
        taskDetail.OwnerId=userDetail.Id;
        
        try{
            insert taskDetail;
        }catch(Exception ex){
            System.debug('Task insertion Failed'+ ex.getMessage());
        }
        
    }

}