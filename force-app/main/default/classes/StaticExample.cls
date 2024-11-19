public class StaticExample {

    public static Integer staticCounter=0;
    public Integer instanceCounter=0;
    
    public void incrementBoth(){
        staticCounter++;
        instanceCounter++;
    }
}