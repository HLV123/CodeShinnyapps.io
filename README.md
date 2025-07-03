# CodeShinnyapps.io

**Tác giả**: Lê Văn Hưng (HE186837)  
**Xây dựng bằng**: R Shiny, Leaflet, Plotly, OpenWeatherMap API

## Bạn có thể ghé xem thử web tại đây : 
https://minimax-ebay.shinyapps.io/he186837/

### ==========================================================================================================================================================

# Weather Dashboard - Interactive Weather Application

A beautiful and interactive weather dashboard built with R Shiny that provides real-time weather information and forecasts for any location worldwide.

## 🌟 Features

### Current Weather Information
- **Real-time Weather Data**: Get current weather conditions for any city
- **Comprehensive Metrics**: View temperature, humidity, feels-like temperature, visibility, wind speed, and air pressure
- **Interactive Map**: Click anywhere on the map to get weather data for that location
- **Location Search**: Search for weather information by city name

### Weather Forecast
- **7-Day Forecast**: Visual forecast cards showing upcoming weather conditions
- **Interactive Charts**: Line charts displaying various weather parameters over time
- **Multiple Metrics**: Track temperature, humidity, pressure, wind speed, and more

### User Interface
- **Responsive Design**: Modern dashboard layout with animated backgrounds
- **Interactive Elements**: Hover effects and smooth transitions
- **Visual Weather Icons**: OpenWeatherMap icons for better weather representation
- **Customizable Views**: Switch between current weather and forecast tabs

## 🚀 Getting Started

### Prerequisites
Make sure you have R installed on your system along with the following packages:

```r
install.packages(c(
  "shiny",
  "shinydashboard", 
  "ggplot2",
  "tidyverse",
  "dplyr",
  "plotly",
  "leaflet",
  "jsonlite"
))
```

## 🔧 Configuration

### API Key Setup
The application uses OpenWeatherMap API. The API key is currently hardcoded in the `server.R` file. For production use, it's recommended to:

1. Store the API key as an environment variable
2. Create a `.env` file (not tracked by git) to store sensitive information

```r
# Recommended approach
api_key <- Sys.getenv("OPENWEATHER_API_KEY")
```

### Default Location
The application defaults to Hanoi, Vietnam. You can change this by modifying the coordinates in `server.R`:

```r
default_lat <- 21.0124  # Your default latitude
default_lon <- 105.5253 # Your default longitude
```

## 📱 Usage

### Main Dashboard (Weather Tab)
1. **Current Weather**: View real-time weather information for the default location
2. **Search**: Enter a city name in the search box and click "Search"
3. **Interactive Map**: Click anywhere on the map to get weather data for that location
4. **Forecast Cards**: Scroll through the 7-day forecast at the bottom

### Forecast Tab
1. **Select Metrics**: Choose from various weather parameters using radio buttons
2. **View Charts**: Interactive line charts show trends over time
3. **Analyze Data**: Hover over chart points for detailed information

## 🎨 Customization

### Styling
The application includes extensive CSS customization in `ui.R`:
- **Animated Background**: Gradient background with smooth transitions
- **Custom Colors**: Orange and red theme throughout the interface
- **Responsive Design**: Grid layout that adapts to different screen sizes
- **Hover Effects**: Interactive elements with smooth animations

### Adding New Features
To extend the application:
1. **New Weather Metrics**: Add new parameters to the API data extraction
2. **Additional Charts**: Create new visualization types using plotly
3. **Export Features**: Add functionality to download weather data
4. **User Preferences**: Store user settings and favorite locations

## 📊 Data Sources

- **Weather Data**: [OpenWeatherMap API](https://openweathermap.org/api)
- **Maps**: Leaflet with OpenStreetMap tiles
- **Icons**: FontAwesome icons for UI elements

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Guidelines
1. Follow R coding standards
2. Add comments for complex functions
3. Test new features thoroughly
4. Update documentation as needed

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- OpenWeatherMap for providing the weather API
- R Shiny community for excellent documentation and examples
- FontAwesome for beautiful icons
- Leaflet for interactive mapping capabilities

---

**Author**: Lê Văn Hưng (HE186837)  
**Built with**: R Shiny, Leaflet, Plotly, OpenWeatherMap API

### =========================================================================================================================================================================


# Bảng Điều Khiển Thời Tiết - Ứng Dụng Thời Tiết Tương Tác

Một bảng điều khiển thời tiết đẹp mắt và tương tác được xây dựng bằng R Shiny, cung cấp thông tin thời tiết thời gian thực và dự báo cho bất kỳ vị trí nào trên thế giới.

## 🌟 Tính Năng

### Thông Tin Thời Tiết Hiện Tại
- **Dữ Liệu Thời Tiết Thời Gian Thực**: Lấy thông tin thời tiết hiện tại cho bất kỳ thành phố nào
- **Số Liệu Toàn Diện**: Xem nhiệt độ, độ ẩm, cảm giác như nhiệt độ, tầm nhìn, tốc độ gió và áp suất khí quyển
- **Bản Đồ Tương Tác**: Nhấp vào bất kỳ đâu trên bản đồ để lấy dữ liệu thời tiết cho vị trí đó
- **Tìm Kiếm Vị Trí**: Tìm kiếm thông tin thời tiết theo tên thành phố

### Dự Báo Thời Tiết
- **Dự Báo 7 Ngày**: Thẻ dự báo trực quan hiển thị điều kiện thời tiết sắp tới
- **Biểu Đồ Tương Tác**: Biểu đồ đường hiển thị các thông số thời tiết khác nhau theo thời gian
- **Nhiều Chỉ Số**: Theo dõi nhiệt độ, độ ẩm, áp suất, tốc độ gió và nhiều thông số khác

### Giao Diện Người Dùng
- **Thiết Kế Tương Thích**: Bố cục bảng điều khiển hiện đại với nền động
- **Các Yếu Tố Tương Tác**: Hiệu ứng hover và chuyển tiếp mượt mà
- **Biểu Tượng Thời Tiết Trực Quan**: Biểu tượng OpenWeatherMap cho biểu diễn thời tiết tốt hơn
- **Chế Độ Xem Tùy Chỉnh**: Chuyển đổi giữa tab thời tiết hiện tại và dự báo

## 🚀 Bắt Đầu

### Yêu Cầu Hệ Thống
Đảm bảo bạn đã cài đặt R trên hệ thống cùng với các gói sau:

```r
install.packages(c(
  "shiny",
  "shinydashboard", 
  "ggplot2",
  "tidyverse",
  "dplyr",
  "plotly",
  "leaflet",
  "jsonlite"
))
```

## 🔧 Cấu Hình

### Thiết Lập API Key
Ứng dụng sử dụng API OpenWeatherMap. Hiện tại API key được mã hóa cứng trong file `server.R`. Để sử dụng trong môi trường sản xuất, khuyến nghị:

1. Lưu trữ API key như một biến môi trường
2. Tạo file `.env` (không được theo dõi bởi git) để lưu trữ thông tin nhạy cảm

```r
# Cách tiếp cận được khuyến nghị
api_key <- Sys.getenv("OPENWEATHER_API_KEY")
```

### Vị Trí Mặc Định
Ứng dụng mặc định là Hà Nội, Việt Nam. Bạn có thể thay đổi bằng cách sửa đổi tọa độ trong `server.R`:

```r
default_lat <- 21.0124  # Vĩ độ mặc định của bạn
default_lon <- 105.5253 # Kinh độ mặc định của bạn
```

## 📱 Cách Sử Dụng

### Bảng Điều Khiển Chính (Tab Thời Tiết)
1. **Thời Tiết Hiện Tại**: Xem thông tin thời tiết thời gian thực cho vị trí mặc định
2. **Tìm Kiếm**: Nhập tên thành phố vào ô tìm kiếm và nhấp "Search"
3. **Bản Đồ Tương Tác**: Nhấp vào bất kỳ đâu trên bản đồ để lấy dữ liệu thời tiết cho vị trí đó
4. **Thẻ Dự Báo**: Cuộn qua dự báo 7 ngày ở phía dưới

### Tab Dự Báo
1. **Chọn Chỉ Số**: Chọn từ các thông số thời tiết khác nhau bằng nút radio
2. **Xem Biểu Đồ**: Biểu đồ đường tương tác hiển thị xu hướng theo thời gian
3. **Phân Tích Dữ Liệu**: Di chuột qua các điểm biểu đồ để xem thông tin chi tiết

## 🎨 Tùy Chỉnh

### Tạo Kiểu
Ứng dụng bao gồm tùy chỉnh CSS mở rộng trong `ui.R`:
- **Nền Động**: Nền gradient với chuyển tiếp mượt mà
- **Màu Sắc Tùy Chỉnh**: Chủ đề màu cam và đỏ trong toàn bộ giao diện
- **Thiết Kế Tương Thích**: Bố cục lưới thích nghi với các kích thước màn hình khác nhau
- **Hiệu Ứng Hover**: Các yếu tố tương tác với hoạt ảnh mượt mà

### Thêm Tính Năng Mới
Để mở rộng ứng dụng:
1. **Chỉ Số Thời Tiết Mới**: Thêm các thông số mới vào việc trích xuất dữ liệu API
2. **Biểu Đồ Bổ Sung**: Tạo các loại trực quan hóa mới bằng plotly
3. **Tính Năng Xuất**: Thêm chức năng tải xuống dữ liệu thời tiết
4. **Tùy Chọn Người Dùng**: Lưu trữ cài đặt người dùng và vị trí yêu thích

## 📊 Nguồn Dữ Liệu

- **Dữ Liệu Thời Tiết**: [OpenWeatherMap API](https://openweathermap.org/api)
- **Bản Đồ**: Leaflet với tiles OpenStreetMap
- **Biểu Tượng**: Biểu tượng FontAwesome cho các yếu tố giao diện

## 🤝 Đóng Góp

Chúng tôi hoan nghênh các đóng góp! Vui lòng tạo Pull Request. Đối với các thay đổi lớn, vui lòng tạo issue trước để thảo luận những gì bạn muốn thay đổi.

### Hướng Dẫn Phát Triển
1. Tuân thủ tiêu chuẩn mã hóa R
2. Thêm nhận xét cho các hàm phức tạp
3. Kiểm tra kỹ lưỡng các tính năng mới
4. Cập nhật tài liệu khi cần thiết

## 📄 Giấy Phép

Dự án này được cấp phép theo Giấy phép MIT - xem file [LICENSE](LICENSE) để biết chi tiết.

## 🙏 Lời Cảm Ơn

- OpenWeatherMap vì cung cấp API thời tiết
- Cộng đồng R Shiny vì tài liệu xuất sắc và các ví dụ
- FontAwesome vì các biểu tượng đẹp
- Leaflet vì khả năng lập bản đồ tương tác

---

## Cảm ơn!
