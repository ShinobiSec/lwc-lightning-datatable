public with sharing class LightningDatatableControllerEscapeMethod {
    //THIS DOES NOT WORK FOR MY EXAMPLE. SEE SECURITY SECTION OF ARTICLE OR BLOG POST FOUND IN .README
    // @AuraEnabled allows the class to be access by your LWC component using import in the JS file.
    @AuraEnabled(cacheable=True)
    // We will be returning contacts in this example
    public static List<Contact> getContacts(Id accountId, String name, String email, Integer rows){
        // Create a list of contacts to be returned
        List<Contact> contacts = new List<Contact>();

        // Create variables for dynamic SOQL query
        String query;
        
        // Create a dynamic query
        String condition = (String.isNotBlank(accountId)
            ? 'AccountId = \'' + accountId + '\''
            : '');
        // Does not execute due to SOQL query exception when escaping single quotes. 
        condition += (String.isNotBlank(name)
        ? (String.isNotBlank(condition) ? + ' AND ' : '') +
        'Name LIKE \'' + '%' + name + '%\''
        : '');
        // Does not execute due to SOQL query exception when escaping single quotes. 
        condition += (String.isNotBlank(email)
        ? (String.isNotBlank(condition) ? + ' AND ' : '') +
        'Email LIKE \'' + '%' + email + '%\''
        : '');
        
        if (String.isNotEmpty(condition))
        {   
            String conditionQueryString = 'SELECT Id, Name, Email, Title, CreatedDate FROM Contact WHERE ' + condition + ' WITH SECURITY_ENFORCED ORDER BY CreatedDate ASC LIMIT :rows';
            System.debug('escapredQueryString: ' + conditionQueryString);
            String escapedQueryString = string.escapeSingleQuotes(conditionQueryString);
            System.debug('escapredQueryString: ' + escapedQueryString);
            contacts = Database.query(escapedQueryString);
            return contacts;
        } else {
            contacts = [SELECT Id, Name, Email, Title, CreatedDate FROM Contact WHERE AccountId = :accountId WITH SECURITY_ENFORCED ORDER BY CreatedDate ASC LIMIT :rows];
            return contacts;
        }
    }
//Ending bracket
}