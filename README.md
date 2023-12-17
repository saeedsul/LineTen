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

#=============================================================================================================

# To run application in terraform:

1. please make sure terraform is installed.
2. Docker is installed.

# how to run it locally:

1. locate Dockerfile in root folder.
2. use powershell or any other command window
3. we need to build api image first and should be named as lineten:10 .
4. navigate to the root folder and type: docker build -t lineten:10 .

# After image is created open terminal and navigate to Iac folder.

1. in your terminal type terraform init
2. terraform apply --auto-approve

terraform should now creae 2 containers for you.

open your browser and type http://localhost:3000/swagger/index.html
