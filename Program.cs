var builder = WebApplication.CreateBuilder(args);

// Add services
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Lấy PORT từ biến môi trường, nếu không có thì dùng 5242 (chạy local)
var port = Environment.GetEnvironmentVariable("PORT") ?? "5242";
app.Urls.Add($"http://*:{port}");

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

// Route mặc định kiểm tra API
app.MapGet("/", () => "🚀 API is running on Render!");

app.Run();
