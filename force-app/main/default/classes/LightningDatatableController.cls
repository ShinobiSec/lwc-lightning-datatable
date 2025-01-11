public with sharing class LightningDatatableController {

    // @AuraEnabled allows the class to be access by your LWC component using import in the JS file.
    @AuraEnabled(cacheable=True)
    // We will be returning contacts in this example
    public static List<Contact> getContacts(Id accountId, String name, String email, Integer rows) 
    {
        // Create a list of contacts to be returned
        List<Contact> contacts = new List<Contact>();

        // Create variables for dynamic SOQL query
        String query;
        
        // Create a dynamic query
        String condition = (String.isNotBlank(accountId)
            ? 'AccountId = \'' + accountId + '\''
            : '');

        condition += (String.isNotBlank(name)
        ? (String.isNotBlank(condition) ? + ' AND ' : '') +
        'Name LIKE \'' + '%' + name + '%\''
        : '');

        condition += (String.isNotBlank(email)
        ? (String.isNotBlank(condition) ? + ' AND ' : '') +
        'Email LIKE \'' + '%' + email + '%\''
        : '');

        if (String.isNotEmpty(condition))
        {   
            query = 'SELECT Id, Name, Email, Title, CreatedDate FROM Contact WHERE ' + condition + ' WITH SECURITY_ENFORCED ORDER BY CreatedDate ASC LIMIT :rows';
            System.debug('query: ' + query);
            contacts = Database.query(query);
        } 
        return contacts;
    }
//Ending bracket
}