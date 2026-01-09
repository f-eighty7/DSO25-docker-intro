# Kopiera exekverbara filer in i vår image

# köra vår exekverbara fil i vår container

# FROM mcr.microsoft.com/dotnet/sdk:9.0

# WORKDIR /app

# COPY ./bin/Debug/net9.0/ .

# CMD ["dotnet", "dso25-docker-intro.dll"]

# Stage 1 - bygg programmet
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

WORKDIR /src

# kopiera projektfiler och installera beroenden
COPY *.csproj ./
RUN dotnet restore

# kopiera av koden och bygg appen
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# steg 2 - Runtime miljö
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "dso25-docker-intro.dll"]