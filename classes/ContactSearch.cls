public class ContactSearch {
    public static List<Contact> searchForContacts(String a, String b){
        List<Contact> x = [SELECT LastName FROM Contact WHERE LastName = :a and MailingPostalCode = :b];
        return x;
        
    }

}