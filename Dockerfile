FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["LineTen.Api/LineTen.Api.csproj", "LineTen.Api/"]
COPY ["LineTen.Persistence/LineTen.Persistence.csproj", "LineTen.Persistence/"]
COPY ["LineTen.Services/LineTen.Services.csproj", "LineTen.Services/"]
COPY ["LineTen.Common/LineTen.Common.csproj", "LineTen.Common/"]
RUN dotnet restore "LineTen.Api/LineTen.Api.csproj"
COPY . .
WORKDIR "/src/LineTen.Api"
RUN dotnet build "LineTen.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "LineTen.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LineTen.Api.dll"]
 