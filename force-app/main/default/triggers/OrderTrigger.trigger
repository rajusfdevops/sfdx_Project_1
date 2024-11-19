trigger OrderTrigger on Order (before insert) {
    List<Order_Placed__e> events = new List<Order_Placed__e>();
    
    for (Order order : Trigger.new) {
        Order_Placed__e event = new Order_Placed__e(
            OrderId__c = order.Id,
            CustomerId__c = order.CustomerId__c,
            OrderAmount__c = order.Amount__c
        );
        events.add(event);
    }
    
    EventBus.publish(events);
}