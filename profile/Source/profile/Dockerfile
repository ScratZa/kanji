#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["Source/profile/profile.csproj", "Source/profile/"]
RUN dotnet restore "Source/profile/profile.csproj"
COPY . .
WORKDIR "/src/Source/profile"
RUN dotnet build "profile.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "profile.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "profile.dll"]
