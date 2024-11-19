public class XML_Example_2 {
    public String result{set;get;}
    public XML_Example_2(){
        Dom.Document doc = new Dom.Document();
        Dom.XMLNode root = doc.createRootElement('College',null, null);
        root.setAttribute('code','IIT002');
        root.setAttribute('University','DU');
        Dom.XMLNode name=root.addChildElement('Name',null,null);
        name.addTextNode('IIT Kanpur');
         Dom.XMLNode phone=root.addChildElement('Phone',null,null);
        phone.addTextNode('040-23445');
         Dom.XMLNode address=root.addChildElement('Address',null,null);
         Dom.XMLNode city=address.addChildElement('City',null,null);
        city.addTextNode('Kanpur');
         Dom.XMLNode state=address.addChildElement('State',null,null);        
        state.addTextNode('U.P.');        
        result=doc.toXmlString();
            
        
    }

}