public class LinkedInManager_1 {
    public String authCodeFromURL { get; set; }
    public Boolean isCode { get; set; }
    public final String consumerKey = '86iull2zzgllky';  // LinkedIn client id
    public final String consumerSecret = 'ZdPYzaH1zZKaBV1P'; // LinkedIn client secret
    public final String redirect_URI = 'https://d5i00000dtcuceal-dev-ed--c.develop.vf.force.com/apex/vf_LinkedIn_1';
    public final String linkedIn_AuthUrl = 'https://www.linkedin.com/oauth/v2/authorization';
    public final String accessToken_EndPoint = 'https://www.linkedin.com/oauth/v2/accessToken';
    public String accessToken { get; set; }
    public String instanceUrl { get; set; }
    public String responseMessage { get; set; }
    public String newHeadline { get; set; } // Property to hold the new headline

    public LinkedInManager_1() {
        authCodeFromURL = ApexPages.currentPage().getParameters().get('code');
        isCode = (authCodeFromURL == null || authCodeFromURL == '');
        System.debug('Constructor: authCodeFromURL=' + authCodeFromURL + ', isCode=' + isCode);
    }

    public PageReference getAuthCode() {
        String encodedRedirectURI = EncodingUtil.urlEncode(redirect_URI, 'UTF-8');
        String requestToAuthURL = linkedIn_AuthUrl + '?response_type=code&client_id=' + consumerKey + 
                                  '&redirect_uri=' + encodedRedirectURI + 
                                  '&state=12345567dggd&scope=r_liteprofile%20r_emailaddress%20w_member_social%20openid';
        System.debug('getAuthCode: Encoded Redirect URI=' + encodedRedirectURI);
        System.debug('getAuthCode: Request to Auth URL=' + requestToAuthURL);
        
        PageReference pageRef = new PageReference(requestToAuthURL);
        pageRef.setRedirect(true);
        return pageRef;
    }

    public void getAccessCode() {
        System.debug('getAccessCode: authCodeFromURL=' + authCodeFromURL);
        if (authCodeFromURL != null && authCodeFromURL != '') {
            HTTP http = new HTTP();
            HTTPRequest request = new HTTPRequest();
            String requestBody = 'grant_type=authorization_code' +
                                 '&code=' + authCodeFromURL +
                                 '&redirect_uri=' + EncodingUtil.urlEncode(redirect_URI, 'UTF-8') +
                                 '&client_id=' + consumerKey +
                                 '&client_secret=' + consumerSecret;
            request.setEndpoint(accessToken_EndPoint);
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            request.setBody(requestBody);

            System.debug('getAccessCode: Request Body=' + requestBody);

            try {
                HTTPResponse response = http.send(request);
                System.debug('getAccessCode: Response Status=' + response.getStatus());
                System.debug('getAccessCode: Response Body=' + response.getBody());

                if (response.getStatusCode() == 200) {
                    // Deserialize the JSON response
                    Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    accessToken = (String) responseBody.get('access_token');
                    instanceUrl = (String) responseBody.get('instance_url');
                    responseMessage = 'Access Token: ' + accessToken + ', Instance URL: ' + instanceUrl;
                    System.debug('getAccessCode: Access Token=' + accessToken + ', Instance URL=' + instanceUrl);
                } else {
                    responseMessage = 'Error: ' + response.getBody();
                    System.debug('getAccessCode: Error Response=' + response.getBody());
                }
            } catch (Exception ex) {
                responseMessage = 'Exception occurred: ' + ex.getMessage();
                System.debug('getAccessCode: Exception=' + ex.getMessage());
            }
        } else {
            responseMessage = 'Authorization code not found.';
            System.debug('getAccessCode: Authorization code not found.');
        }
    }

    public void updateLinkedInProfile() {
        System.debug('updateLinkedInProfile: Access Token=' + accessToken);
        if (accessToken != null) {
            HTTP http = new HTTP();
            HTTPRequest request = new HTTPRequest();
            request.setEndpoint('https://api.linkedin.com/v2/me');
            request.setMethod('GET');
            request.setHeader('Authorization', 'Bearer ' + accessToken);

            try {
                HTTPResponse response = http.send(request);
                System.debug('updateLinkedInProfile: Response Status=' + response.getStatus());
                System.debug('updateLinkedInProfile: Response Body=' + response.getBody());

                if (response.getStatusCode() == 200) {
                    // Update LinkedIn profile with new headline
                    Map<String, Object> profile = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    profile.put('headline', newHeadline);

                    HTTPRequest updateRequest = new HTTPRequest();
                    updateRequest.setEndpoint('https://api.linkedin.com/v2/me');
                    updateRequest.setMethod('POST');
                    updateRequest.setHeader('Authorization', 'Bearer ' + accessToken);
                    updateRequest.setHeader('Content-Type', 'application/json');
                    updateRequest.setBody(JSON.serialize(profile));

                    System.debug('updateLinkedInProfile: Update Request Body=' + JSON.serialize(profile));

                    HTTPResponse updateResponse = http.send(updateRequest);
                    System.debug('updateLinkedInProfile: Update Response Status=' + updateResponse.getStatus());
                    System.debug('updateLinkedInProfile: Update Response Body=' + updateResponse.getBody());

                    if (updateResponse.getStatusCode() == 200) {
                        responseMessage = 'LinkedIn profile updated successfully.';
                    } else {
                        responseMessage = 'Error updating LinkedIn profile: ' + updateResponse.getBody();
                        System.debug('updateLinkedInProfile: Error Response=' + updateResponse.getBody());
                    }
                } else {
                    responseMessage = 'Error fetching LinkedIn profile: ' + response.getBody();
                    System.debug('updateLinkedInProfile: Error Response=' + response.getBody());
                }
            } catch (Exception ex) {
                responseMessage = 'Exception occurred: ' + ex.getMessage();
                System.debug('updateLinkedInProfile: Exception=' + ex.getMessage());
            }
        } else {
            responseMessage = 'Access token not found.';
            System.debug('updateLinkedInProfile: Access token not found.');
        }
    }
}