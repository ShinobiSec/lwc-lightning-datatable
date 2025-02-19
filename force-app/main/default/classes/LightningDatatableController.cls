public with sharing class LightningDatatableController {

    // @AuraEnabled allows the class to be access by your LWC component using import in the JS file.
    @AuraEnabled(cacheable=True)
    // We will be returning contacts in this example
    public static List<Contact> getContacts(Id accountId, String name, String email, Integer rows) 
    {
        // Create a list of contacts to be returned
        List<Contact> contacts = new List<Contact>();

    //Create map for query with binds
        Map<String, Object> params = new Map<String, Object>{'accountId' => accountId, 'name' => '%' + name + '%', 'email' => '%' + email + '%', 'rows' => rows};
        
        //Perform query based on existing params
        
        if(accountId != NULL && string.isNotBlank(name) && string.isNotBlank(email)){
            String query = 'SELECT Id, Name, Email FROM Contact WHERE AccountId = :accountId AND Name LIKE :name AND Email LIKE :email LIMIT :rows';
            contacts = Database.queryWithBinds(query, params, AccessLevel.USER_MODE);
        }
        
        else if(accountId != NULL && string.isNotBlank(name)){
            String query = 'SELECT Id, Name, Email FROM Contact WHERE AccountId = :accountId AND Name LIKE :name LIMIT :rows';
            contacts = Database.queryWithBinds(query, params, AccessLevel.USER_MODE);
        }
        
        else if(accountId != NULL && string.isNotBlank(email)){
            String query = 'SELECT Id, Name, Email FROM Contact WHERE AccountId = :accountId AND Email LIKE :email LIMIT :rows';
            contacts = Database.queryWithBinds(query, params, AccessLevel.USER_MODE);
        }
        
        else if(accountId != NULL){
            String query = 'SELECT Id, Name, Email FROM Contact WHERE AccountId = :accountId LIMIT :rows';
            contacts = Database.queryWithBinds(query, params, AccessLevel.USER_MODE);
        }
                   
        return contacts;
    }
//Ending bracket
}
