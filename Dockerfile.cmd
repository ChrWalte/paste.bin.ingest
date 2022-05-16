# build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# copy everything into the current directory
COPY . .

# publish the project in release mode
RUN dotnet publish ./paste.bin.ingest.cmd/paste.bin.ingest.cmd.csproj -c release

# final/running stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final

# create and copy build files into paste.bin.ingest.cmd folder
WORKDIR /paste.bin.ingest.cmd
COPY --from=build /src/paste.bin.ingest.cmd/bin/release/net6.0/publish .

# start sele at startup
ENTRYPOINT ["dotnet", "paste.bin.ingest.cmd.dll"]