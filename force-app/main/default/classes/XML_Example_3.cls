public class XML_Example_3 {
    public String result {set;get;}
    public String searchText {set;get;}
    
    public void XML_Example_3(){
        Account acc=[Select id, Name, Phone, Industry,(Select LastName, FirstName, Phone from Contacts) from Account Where name=:searchText];
        Dom.Document doc = new Dom.Document();
        DOM.XMLNode root = doc.createRootElement('Company',null,null);
        root.setAttribute('Name',acc.Name);
        root.setAttribute('Industry',acc.Industry);
        root.setAttribute('Phone',acc.Phone);
        Dom.XMLNode head =root.addChildElement('Header',null,null);
        head.setAttribute('Status','Success');
        head.setAttribute('Persons',''+acc.contacts.size());
        
        if(acc.contacts.size()>0){
            for(Contact c :acc.Contacts){
                Dom.XMLNode person=root.addChildElement('Person',null,null);
                Dom.XMLNode lname=person.addChildElement('LastName',null,null);
                Dom.XMLNode fname=person.addChildElement('FistName',null,null);
                Dom.XMLNode phone=person.addChildElement('Phone',null,null);
                lname.addTextNode(c.lastname);
                fname.addTextNode(c.firstname);
                phone.addTextNode(c.phone);
            }
        }
        result = doc.toXmlString();
        
    }

}