# To run this project on local machine you need to at least have LocalDb or sqlExpress installed.

# In the Api project the connection string is connected to (localdb)\\mssqllocaldb.

# Project is using EF code first so it will create the database on the first call to any of the api endpoints.

# Database is seeded with 3 records for each table (Customer, Orders, Products).

# We have 65 unit Tests that covers all scenarios for both controllers and services.

#=============================================================================================================

# To run this application in a container :

1. change the launch profile to docker-compose in visual studio or via command line docker-compose up in the same directory where the compose file is.

2. once you run docker-compose it will create two containers
   2.1 lineten_db_container
   2.2 lineten_api_container

3. lineten_api_container is dependent on lineten_db_container because it uses the Service name (SqlServerDb) to be able to connect to the database.

#==============================================================================================================

All api endpoints are RESTFUL it can be called from swagger.
