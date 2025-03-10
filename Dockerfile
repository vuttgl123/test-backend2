# Bước 1: Dùng hình ảnh .NET SDK để build ứng dụng
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Copy file .csproj vào container và restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy toàn bộ source code và build ứng dụng
COPY . ./
RUN dotnet publish -c Release -o /publish

# Bước 2: Dùng hình ảnh .NET runtime để chạy ứng dụng
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app

# Copy ứng dụng đã build từ bước trước
COPY --from=build /publish .

# Mở port 80 để container có thể nhận request
EXPOSE 80

# Chạy ứng dụng
ENTRYPOINT ["dotnet", "test_backend2.dll"]
