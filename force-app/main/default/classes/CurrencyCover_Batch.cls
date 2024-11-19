global class CurrencyCover_Batch implements Database.Batchable<SObject>, Database.AllowsCallouts {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Amount, DOLL_Value__c FROM Opportunity';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<SObject> scope) {
        String inrcurrency='INR';
        String endpoint= 'https://api.currencylayer.com/live?access_key=f08c07df8c2e43bbb8cf2b4bc60e465d&source='+inrcurrency+'&currencies=USD&format=1';
        HTTP hp = new HTTP();
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        
        HTTPResponse response;
        try {
            response = hp.send(request);
        } catch (Exception e) {
            System.debug('HTTP Request failed: ' + e.getMessage());
            return;
        }
        
        String result = response.getBody();
        System.debug('API Response: ' + result);
        
        Decimal exchangeRate;
        try {
            Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(result);
            Map<String, Object> quotes = (Map<String, Object>) jsonResponse.get('quotes');
            exchangeRate = (Decimal) quotes.get('INRUSD');
        } catch (Exception e) {
            System.debug('JSON Parsing failed: ' + e.getMessage());
            return;
        }
        
        System.debug('Exchange Rate: ' + exchangeRate);
        
        List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
        for (SObject sObj : scope) {
            Opportunity op = (Opportunity) sObj;
            if (op.Amount != null) {
                op.DOLL_Value__c = '$ ' + (exchangeRate * op.Amount);
                opportunitiesToUpdate.add(op);
            }
        }
        
        if (!opportunitiesToUpdate.isEmpty()) {
            update opportunitiesToUpdate;
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        System.debug('Batch processing completed.');
    }
}