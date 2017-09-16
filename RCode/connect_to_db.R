

channel=odbcDriverConnect("Driver=MySQL ODBC 5.3 Unicode Driver;Server=localhost;Database=test;Uid=root;Pwd=")

## fetch column name of a table
sqlColumns(channel, "admin")

## fetch row from a table
sqlFetch(channel, "admin", max = 5)

## fetch data using sql query
tt=sqlQuery(channel, "select * from admin", errors = TRUE)

tt$Id


## close connection
close(channel)



