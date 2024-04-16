# builds our image using dotnet's sdk
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source
COPY . ./webapp/
WORKDIR /source/webapp
RUN dotnet restore
RUN dotnet publish -c release -o /app --no-restore

# runs it using aspnet runtime
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "webapp.dll"]

#
## Builds our image using .NET SDK
#FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
#WORKDIR /source
#COPY . ./webapp/
#WORKDIR /source/webapp
#RUN dotnet restore
#RUN dotnet publish -c release -o /app --no-restore
#
## Runs it using ASP.NET runtime
#FROM mcr.microsoft.com/dotnet/aspnet:8.0
#WORKDIR /app
#COPY --from=build /app ./
#ENTRYPOINT ["dotnet", "webapp.dll"]
#