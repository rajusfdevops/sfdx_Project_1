public class XML_Example_1 {
    public String result{set;get;}
        public XML_Example_1(){
            Dom.Document doc = new Dom.Document();
            Dom.XMLNode root=doc.createRootElement('Name','https://www.intelogic.com/','intelogic');
            Dom.XMLNode lname=root.addChildElement('LastName',null,null);
            lname.addTextNode('Raju');
            Dom.XMLNode fname=root.addChildElement('FirstNAme',null,null);
            fname.addTextNode('Prasad');
            result=doc.toXmlString();
        }

}