FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

#copy the csproj

COPY *.csproj ./
RUN dotnet restore

#copy everything for build creation

COPY . ./
RUN dotnet publish -c Release -o /out


#running image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
#necessary to add exppose and env variable as below
EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet","app-code.dll"]