# Create a new OpenShift project
oc new-project mydemo55

# Add the database
oc new-app postgresql-ephemeral

# Add the .NET Core application
oc new-app --as-deployment-config=true dotnet:5.0-ubi8~https://github.com/redhat-developer/s2i-dotnetcore-persistent-ex#dotnet-5.0 --context-dir app

# Add envvars from the postgresql secret, and database service name envvar.
oc set env dc/s2i-dotnetcore-persistent-ex --from=secret/postgresql -e database-service=postgresql

# Make the .NET Core application accessible externally and show the url
oc expose service s2i-dotnetcore-persistent-ex
oc get route s2i-dotnetcore-persistent-ex
