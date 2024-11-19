@IsTest
public with sharing class PublishPlatformEventCallbackTest {

@IsTest
    static void testFailedEvents(){
        Order_Detail__e orderDetail = new Order_Detail__e(
        Order_Number__c = 'ORD-10001',
        Generate_Invoice__c=true);
        PublishPlatformEventCallback cb = new PublishPlatformEventCallback();
        EventBus.publish(orderDetail, cb);
        Test.getEventBus().fail();
        List<task> taskList=[Select Id, Subject, Description From Task Where Subject='Plaform Event Published Failed' ] ;
        System.Assert.areEqual(1,taskList.size(),'Task creation Failed');
    }
    @IsTest
    static void testSuccessEvents(){
        Order_Detail__e orderDetail = new Order_Detail__e(
        Order_Number__c = 'ORD-10001',
        Generate_Invoice__c=true);
        PublishPlatformEventCallback cb = new PublishPlatformEventCallback();
        Test.startTest();
        EventBus.publish(orderDetail, cb);
        Test.stopTest();
        Test.getEventBus().fail();
        List<task> taskList=[Select Id, Subject, Description From Task Where Subject='Plaform Event Published Successfully' ] ;
        System.Assert.areEqual(1,taskList.size(),'Task creation Success');
    }
}