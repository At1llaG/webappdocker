


# builds our image using .net sdk
from mcr.microsoft.com/dotnet/sdk:8.0 as build
workdir /source
copy . .
RUN dotnet restore "webapp.csproj" --disable-parallel
RUN dotnet publish "webapp.csproj" -c release -o /app --no-restore

# runs it using asp.net runtime
from mcr.microsoft.com/dotnet/aspnet:8.0
workdir /app
copy --from=build /app ./
expose 8080
entrypoint ["dotnet", "webapp.dll"]






##Buid stage
#FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS build
#WORKDIR /source
#COPY . .
#RUN dotnet restore "webapp.csproj" --disable-parallel
#RUN dotnet publish "webapp.csproj" -c release -o /app --no-restore
#
## Serve stage
#FROM mcr.microsoft.com/dotnet/aspnet:6.0-focal
#WORKDIR /app
#COPY --from=build /app ./
#
#EXPOSE 80
#
#ENTRYPOINT ["dotnet", "webapp.dll"]
#
#






## builds our image using dotnet's sdk
#FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
#WORKDIR /source
#COPY . ./webapp/
#WORKDIR /source/webapp
#RUN dotnet restore
#RUN dotnet publish -c release -o /app --no-restore
#
## runs it using aspnet runtime
#FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
#WORKDIR /app
#COPY --from=build /app ./
#ENTRYPOINT ["dotnet", "webapp.dll"]

