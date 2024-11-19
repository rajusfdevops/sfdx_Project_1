public class IntegrationLogic {
    public String accessToken { get; set; }
    public String instanceurl { get; set; }
    public String responseMessage { get; set; }

    public void requestAccessToken() {
        // Need to get the client id, client secret, user name, password, server name
        List<Integration_Setup__c> integrationList = [SELECT Id, clientId__c, ServerName__c, ServerUserName__c, ServerPassword__c, clientsecret__c FROM Integration_Setup__c WHERE ServerName__c = 'd5i00000dtcuceal'];

        if (integrationList != null && integrationList.size() > 0) {
            String accessTokenEndpoint = 'https://login.salesforce.com/services/oauth2/token';
            String requestBody = 'grant_type=password' +
                                 '&client_id=' + integrationList[0].clientId__c +
                                 '&client_secret=' + integrationList[0].clientsecret__c +
                                 '&username=' + integrationList[0].ServerUserName__c +
                                 '&password=' + integrationList[0].ServerPassword__c;

            HTTP hp = new HTTP();
            HTTPRequest request = new HTTPRequest();
            request.setEndpoint(accessTokenEndpoint);
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            request.setBody(requestBody);

            try {
                HTTPResponse response = hp.send(request);
                System.debug('Response Status: ' + response.getStatus());
                System.debug('Response Body: ' + response.getBody());

                if (response.getStatusCode() == 200) {
                    // Deserialize the JSON response
                    Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    accessToken = (String) responseBody.get('access_token');
                    instanceurl = (String) responseBody.get('instance_url');
                    responseMessage = 'Access Token: ' + accessToken + ', Instance URL: ' + instanceurl;
                } else {
                    responseMessage = 'Error: ' + response.getBody();
                }
            } catch (Exception ex) {
                responseMessage = 'Exception occurred: ' + ex.getMessage();
            }
        } else {
            responseMessage = 'No integration setup found.';
        }
    }

    public void requestToken() {
        // To get access token
        requestAccessToken();
    }
}