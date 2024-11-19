public class LinkedInManager {
    
    public String authCodeFromURL { get; set; }
    public Boolean isCode { get; set; }
    public final String consumerKey = '86iull2zzgllky';  // LinkedIn client id
    public final String consumerSecret = 'ZdPYzaH1zZKaBV1P'; // LinkedIn client secret
    public final String redirect_URI = 'https://d5i00000dtcuceal-dev-ed--c.develop.vf.force.com/apex/VF_LinkedIn';
    public final String linkedIn_AuthUrl = 'https://www.linkedin.com/oauth/v2/authorization';
    public final String accessToken_EndPoint = 'https://www.linkedin.com/oauth/v2/accessToken';
    
    public LinkedInManager() {
        authCodeFromURL = ApexPages.currentPage().getParameters().get('code');
        isCode = (authCodeFromURL == null || authCodeFromURL == '');
    }
    
    public PageReference getAuthCode() {
        String encodedRedirectURI = EncodingUtil.urlEncode(redirect_URI, 'UTF-8');
        String requestToAuthURL = linkedIn_AuthUrl + '?response_type=code&client_id=' + consumerKey + 
                                  '&redirect_uri=' + encodedRedirectURI + 
                                  '&state=12345567dggd&scope=r_liteprofile%20r_emailaddress%20w_member_social';
        System.debug('Auth URL: ' + requestToAuthURL); // Debug statement to verify the URL
        PageReference pageRef = new PageReference(requestToAuthURL);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public void getAccessCode() {
        HTTP http = new HTTP();
        HTTPRequest request = new HTTPRequest();
        HTTPResponse response;
        String requestBody = 'code=' + authCodeFromURL + '&grant_type=authorization_code' +
                             '&client_id=' + consumerKey + 
                             '&client_secret=' + consumerSecret + 
                             '&redirect_uri=' + EncodingUtil.urlEncode(redirect_URI, 'UTF-8');
        request.setMethod('POST');
        request.setEndpoint(accessToken_EndPoint);
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody(requestBody);
        
        try {
            response = http.send(request);
            if (response.getStatusCode() == 200) {
                Map<String, Object> tokenInfo = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                System.debug('Token info: ' + tokenInfo);
            } else {
                System.debug('Error response: ' + response.getBody());
            }
        } catch (System.Exception ex) {
            System.debug('Exception occurred: ' + ex.getStackTraceString() + ' ' + ex.getMessage());
        }
    }
}