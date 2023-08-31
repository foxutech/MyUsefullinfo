# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY src/HelloWorldApp/Helloworldapp.web/Helloworldapp.web.csproj .
RUN dotnet restore
COPY src/HelloWorldApp .
RUN dotnet publish -c Release --output ./src/HelloWorldApp/HelloWorldapp.sln

# Stage 2: Create the final runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /src/HelloWorldApp/myapp .
ENTRYPOINT ["dotnet", "HelloWorldApp.dll"]

