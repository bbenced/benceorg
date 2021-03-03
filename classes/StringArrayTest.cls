public class StringArrayTest {

    public static List<String> generateStringArray(Integer n){
        List<String> x = new List<String>();
        for(Integer i = 0;i<n;++i){
            x.add('Test ' + i);
        }
        return x;
    }
}