String query = 'Name LIKE %name%';
System.debug('STRING >>> ' + query);

string.escapeSingleQuotes(query);
System.debug('escapeSingleQuotes >>> ' + query);

String name = 'RIP Donnie';
query = 'Name LIKE \'' + '%' + name + '%\'';
System.debug('properly formatted query string >>> ' + query);
