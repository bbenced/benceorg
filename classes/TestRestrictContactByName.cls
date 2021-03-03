@isTest
public class TestRestrictContactByName {
    @isTest static void testInsertWrongName(){
        Contact a = new Contact();
        a.LastName = 'INVALIDNAME';
        
        
        Test.startTest();
      	Database.SaveResult result = Database.insert(a);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() >0);

    }
}