trigger ShippingTrigger on Order_Placed__e (after insert) {
    for (Order_Placed__e event : Trigger.new) {
        // Logic to prepare the order for shipping
        System.debug('Preparing shipping for Order ID: ' + event.OrderId__c);
    }
}