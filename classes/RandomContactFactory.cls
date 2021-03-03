public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer n , String lastName){
        List<Contact> x = new List<Contact>();
        
        for(Integer i = 0;i<n;++i){
            String name =  'Test ' + String.valueOf(i);
            System.debug(name);
            x.add(new Contact(FirstName = name,LastName = lastName));
        }
        return x;
    }
}