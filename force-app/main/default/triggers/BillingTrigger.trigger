trigger BillingTrigger on Order_Placed__e (after insert) {
    for (Order_Placed__e event : Trigger.new) {
        // Logic to generate invoice based on the order
        System.debug('Generating invoice for Order ID: ' + event.OrderId__c);
    }
}