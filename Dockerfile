FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/runtime:6.0
EXPOSE 50000
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "TeamXServer.dll"]