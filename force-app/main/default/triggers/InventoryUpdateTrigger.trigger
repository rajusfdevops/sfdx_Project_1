trigger InventoryUpdateTrigger on Order_Placed__e (after insert) {
    for (Order_Placed__e event : Trigger.new) {
        // Logic to update inventory based on the order
        System.debug('Updating inventory for Order ID: ' + event.OrderId__c);
    }
}