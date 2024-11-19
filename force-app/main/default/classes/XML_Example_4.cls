public class XML_Example_4 {
    public String xmlString{set;get;}
    public String result{set;get;}
    public void convert(){
        Dom.Document doc = new DOM.Document();
        doc.load(xmlString);
        DOM.xmlNode root = doc.getRootElement();
        result = root.getName(); //getName: Name of the element
        //getText() : Vlaue of the element
        ////getChildElements(): List of child elements for the given node.
        List<DOM.XMLNode> childs= root.getChildElements();
        //Take one by one elements from the childs and get name and value
        for(DOM.XMLNode c: childs){
            result=result+'\n'+c.getName()+ ' :'+c.getText();
        }
    }
}