public class ContactAndLeadSearch {

    public static List<List<sObject>> searchContactsAndLeads(String a){

        List<List<sObject>> x = [FIND :a IN ALL FIELDS RETURNING Contact(FirstName, LastName), Lead(FirstName,LastName)];
        return x;
    }
}