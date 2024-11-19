@RestResource(urlMapping='/LeadService/*')
global class LeastRestService {
    @httpget
    global static list<lead> getLeads(){
        RestRequest req=RestContext.request;
        RestResponse res = RestContext.response;
        System.debug('request :'+req);
        System.debug('request :'+req.requestURI);
        String requestURI=req.requestURI;
        
        String lName =requestURI.substring(requestURI.lastIndexOf('=')+1);
        System.debug('lName :'+lName);
        String leadname='%'+lName+'%';
        List<Lead> leadList= [Select Id, Name, Email, Company, Phone, MobilePhone From Lead Where Name like:leadname ];
        return leadList;
    }
    
    @httppost
    global static String createNewLead(String fname,String lname,String cname, String leademail, String mobilenumber){
        String resMessage;
        try{
            Lead l=new Lead();
            l.FirstName=fname;
            l.LastName=lname;
            l.Company=cname;
            l.Email=leademail;
            l.MobilePhone=mobilenumber;
            insert l;
            resMessage ='Lead is created successfully with id as :'+l.Id;
        }catch(Exception ex){
            resMessage='Error Occurred during new lead creation =>'+ex.getMessage();
        }
        return resMessage;
        
    }
    
    @httpPatch
    global static String updateLeadEmail(String newEmail){
        String resMessage;
        String oldEmail;
        try{
            
            RestRequest req=RestContext.request;
            String requestURI= req.requestURI;
            String leadId=requestURI.substring(requestURI.lastIndexOf('=')+1);
            lead myLead=[Select Id,email From Lead Where id=:leadId];
            if(myLead!=null && myLead.Email!=newEmail){
                oldemail=myLead.Email;
                myLead.Email=newEmail;
                update myLead;
                 resMessage='Lead updated from old email'+oldemail+' to new email as '+newEmail;	
            }else {
                resMessage='Current Lead has same email as new email';
            }
            
        }catch(Exception ex){
                   
            resMessage='Exception Occurec during the lead updates'+ex.getMessage();
        }
        return  resMessage;
    }
    
    @httpDelete
    global static String deleteLeadRecords()
    {
        integer leadcount=0;
        try{
            RestRequest req=RestContext.request;
            RestResponse res = RestContext.response;
            System.debug('request :'+req);
            System.debug('request :'+req.requestURI);
            String requestURI=req.requestURI;
            
            String lName =requestURI.substring(requestURI.lastIndexOf('=')+1);
            System.debug('lName :'+lName);
            String leadname='%'+lName+'%';
            
            List<Lead> leadList= [Select Id, Name, Email, Company, Phone, MobilePhone From Lead Where Name like:leadname ];
            if(leadList!=null && leadList.size()>0){
                leadcount=leadList.size();
            }
            
            delete leadList;           
        }catch(Exception ex){
            return 'Exception occured during delete==>'+ex.getMessage();
        }
        return 'Lead deleted successfully => Lead count is : '+leadcount;
        
        
    }
}