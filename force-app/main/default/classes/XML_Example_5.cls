public class XML_Example_5 {
    
    public Blob body {set;get;}
    public String result{set;get;}
    
    public XML_Example_5(){
        Document d=[SELECT id,body from Document where name ='Test'];
        String xmlString=d.body.toString();
        Dom.Document doc = new Dom.Document();
        doc.load(xmlString);
        Dom.XMLNode root = doc.getRootElement();
        result=root.getName();
        //result=result+'value :'+root.getAttribute('Name');
        List<Dom.XMLNode> childs=root.getChildElements();
        for(Dom.XMLNode c: childs){
            result=result+'\n '+c.getName()+' :'+c.getText();
        }
        body=null;
    }

}