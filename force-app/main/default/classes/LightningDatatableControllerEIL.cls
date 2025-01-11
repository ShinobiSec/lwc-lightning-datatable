public with sharing class LightningDatatableControllerEIL {
    //THIS DOES NOT WORK FOR MY EXAMPLE. SEE SECURITY SECTION OF ARTICLE OR BLOG POST FOUND IN .README
    // @AuraEnabled allows the class to be access by your LWC component using import in the JS file.
    @AuraEnabled(cacheable=True)
    // We will be returning contacts in this example
    public static List<Contact> getContacts(Id accountId, String name, String email, Integer rows)
    {
        // Create a list of contacts to be returned
        List<Contact> contacts = new List<Contact>();
        // When LWC loads, this works because :tempvar works when paired with EQUALS/= operator.
        if (accountId != NULL && Name == '' && email == '' && rows != NULL) {
            contacts = [SELECT Id, Name, Email, Title, CreatedDate FROM Contact WHERE 
            AccountId = :accountId WITH SECURITY_ENFORCED ORDER BY CreatedDate ASC LIMIT :rows];
        }
        // LIKE :bindvar does not return results. Must use Database.query(escapedstring);
        else if (accountId != NULL && Name != '' && email == '' && rows != NULL) {
            contacts = [SELECT Id, Name, Email, Title, CreatedDate FROM Contact WHERE 
            AccountId = :accountId AND Name LIKE :name WITH SECURITY_ENFORCED ORDER BY CreatedDate ASC LIMIT :rows];
        }
        // LIKE :bindvar does not return results. Must use Database.query(escapedstring);
        else if (accountId != NULL && Name == '' && email != '' && rows != NULL) {
            contacts = [SELECT Id, Name, Email, Title, CreatedDate FROM Contact WHERE 
            AccountId = :accountId AND Email LIKE :name WITH SECURITY_ENFORCED ORDER BY CreatedDate ASC LIMIT :rows];
        }
    return contacts;
    }
}