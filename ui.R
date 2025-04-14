library(shiny)
library(shinydashboard)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(plotly)
library(leaflet)
library(jsonlite)

ui <- dashboardPage(
  dashboardHeader(title = "Interactive Map"),
  dashboardSidebar(sidebarMenu(
    tags$style(HTML(".sidebar-user-panel { display: none; }")),  # Ẩn sidebarUserPanel
    sidebarUserPanel("Lê Văn Hưng HE186837"),
    textInput("searchText", label = "Location:", value = ""),
    actionButton("searchButton", "Search"),
    
    menuItem("Weather", tabName = "weather"),
    menuItem("Forecast", tabName = "forecast")
  )),
  dashboardBody(
    tags$head(
      tags$style(HTML('<link href="https://kit-free.fontawesome.com/releases/latest/css/free.min.css" rel="stylesheet">')),
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
      tags$style(HTML(
        '
        @keyframes slideBackground {
          0% {
            background-position: 0 0;
          }
          100% {
            background-position: 100% 100%;
          }
        }

        .content-wrapper {
          background: linear-gradient(to top right, #ff7f50, #ff6347, #f0e68c);
          background-size: 200% 200%;
          animation: slideBackground 8s ease-in-out infinite;
        }

        .feature-row {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
          gap: 15px;
          justify-content: center;
        }

        .forecast-box {
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          margin: 10px;
          padding: 15px;
          width: 140px;
          height: 180px;
          border-radius: 12px;
          background-color: #ff8c00;
          box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
          text-align: center;
          font-size: 16px;
          flex-shrink: 0;
          transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .forecast-box:hover {
          transform: translateY(-5px);
          box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        .forecast-icon {
          font-size: 30px;
          margin-bottom: 10px;
        }

        .forecast-temp {
          font-size: 16px;
          font-weight: bold;
          color: #2f4f4f;
          text-transform: uppercase;
          letter-spacing: 1px;
        }

        .box {
          border-radius: 8px;
          box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
          padding: 12px;
          font-size: 14px;
        }

        .box-icon {
          font-size: 18px;
          margin-right: 8px;
        }

        .custom-text {
          font-family: "Arial", sans-serif;
          font-weight: 600;
          font-size: 18px;
          color: #2e2e2e; 
        }

        .custom-text-output1 {
          font-size: 30px;
          font-weight: 700;
          color: #2e2e2e;
          margin-bottom: 5px
        }

        .custom-icon {
          font-size: 40px;
          color: #ff4500;
          margin-right: 10px;
        }

        .custom-text-output2 {
          font-size: 30px;
          font-weight: bold;
          color: #000000;
        }

        .map-container {
          height: 55vh;
          border-radius: 10px;
          box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .forecast-box img {
          border-radius: 50%;
          border: 2px solid #ff6347;
        }

        .forecast-temp, .forecast-box p {
          color: #fff;
          text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.4);
        }

        .line-chart {
          background-color: #f9f9f9;
          padding: 15px;
          border-radius: 8px;
          box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
          height: 540px;  /* Tùy chỉnh chiều cao của line chart */
          width: 100%; /* Đảm bảo biểu đồ chiếm hết chiều rộng của background */
        }

        .radio {
            display: block;
            margin-bottom: 10px;
        }

        .radio input[type="radio"] {
            margin-right: 10px;
        }

        .radio label {
            font-size: 16px;
            font-weight: normal;
            color: #333;
            cursor: pointer;
            display: block;
            padding-left: 10px;
            padding-right: 10px;
            padding-top: 5px;
            padding-bottom: 5px;
        }

        /* Thêm phần CSS cho phần location */
        .custom-location {
            font-size: 30px;
            font-weight: bold;
            color: #f9f9f9;  
            margin: 5px 0;
            padding: 5px;
            border-radius: 12px;
            background-color: rgba(255, 99, 71, 0.2);  /* Nền trong suốt */
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .custom-location:hover {
            transform: scale(1.05);  /* Tạo hiệu ứng phóng to khi hover */
        }
    '
      ))
    ),
    tabItems(
      tabItem(tabName = "weather",
              fluidRow(
                column(
                  width = 4,
                  tags$div(p("Current Weather", class = "custom-text", style = 'font-size:50px;margin-bottom:5px;font-weight:bold')),
                  tags$div(
                    style = "display: flex; align-items: center;font-size:30px;margin-bottom:5px;font-weight:bold", 
                    tags$div(tags$span(textOutput("location"), class = "custom-text-output1")),
                    tags$i(class = "fas fa-cloud-sun-rain custom-cloud1")
                  ),
                  tags$div(br()),
                  tags$div(
                    style = "display: flex; align-items: center;font-size:30px;margin-bottom:5px;font-weight:bold",
                    p("Current Temperature: ", class = "custom-text-output2"),
                    tags$div(
                      tags$span(textOutput("temperature"), class = "custom-text-temp")
                    )
                  ),
                  tags$div(br()),
                  box(width = 4, title = div(tags$i(class = "fa-solid fa-droplet box-icon"), "Humidity"),
                      textOutput("humidity"), background = "aqua"),
                  box(width = 4, title = div(tags$i(class = "fas fa-temperature-high box-icon"), "Feels Like"),
                      textOutput("feels_like"), background = "red"),
                  box(width = 4, title = div(tags$i(class = "fas fa-smog box-icon"), "Weather Condition"),
                      textOutput("weather_condition"), background = "olive"),
                  box(width = 4, title = div(tags$i(class = "fas fa-eye box-icon"), "Visibility"),
                      textOutput("visibility"), background = "teal"),
                  box(width = 4, title = div(tags$i(class = "fas fa-wind box-icon"), "Wind Speed"),
                      textOutput("wind_speed"), background = "navy"),
                  box(width = 4, title = div(tags$i(class = "fas fa-globe-americas box-icon"), "Air Pressure"),
                      textOutput("air_pressure"), background = "maroon")
                ),
                tags$div(
                  box(width = 12, leafletOutput("map"), class = 'map-container'),
                  style = "display: flex; justify-content: center; align-items: center; height: 70vh;"
                ),
                fluidRow(column(width = 12, uiOutput("forecast_boxes")))
              )
      ),
      tabItem(tabName = "forecast",
              tags$div(style = "display: flex; align-items: center;", tags$div(textOutput("location_"), class = "custom-location")),
              column(width = 4, 
                     box(radioButtons("feature", "Features:", 
                                      choices = list("temp", "feels_like", "temp_min", "temp_max", "pressure", "sea_level", "grnd_level", 
                                                     "humidity", "speed", "deg", "gust"), inline = FALSE), 
                         class = "box-fc")),
              box(plotlyOutput("line_chart", width = "100%", height = "520px"), class = "line-chart")
      )
    )
  )
)

