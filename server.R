library(shiny)
library(shinydashboard)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(plotly)
library(leaflet)
library(jsonlite)

get_weather_info <- function(lat, lon) {
  if (missing(lat) || missing(lon)) stop("lat and lon must be provided!")
  
  api_key <- "a9cca8b2fb5c5dee62c8e0fba2de8c4c"
  API_call <- "https://api.openweathermap.org/data/2.5/weather?lat=%s&lon=%s&appid=%s"
  complete_url <- sprintf(API_call, lat, lon, api_key)
  json <- fromJSON(complete_url)
  
  location <- json$name
  temp <- json$main$temp - 273.2
  feels_like <- json$main$feels_like - 273.2
  humidity <- json$main$humidity
  weather_condition <- json$weather$description
  visibility <- json$visibility / 1000
  wind_speed <- json$wind$speed
  air_pressure <- json$main$pressure
  
  weather_info <- list(
    Location = location,
    Temperature = temp,
    Feels_like = feels_like,
    Humidity = humidity,
    WeatherCondition = weather_condition,
    Visibility = visibility,
    Wind_speed = wind_speed,
    Air_pressure = air_pressure
  )
  return(weather_info)
}

get_forecast <- function(lat, lon) {
  if (missing(lat) || missing(lon)) stop("lat and lon must be provided!")
  
  api_key <- "a9cca8b2fb5c5dee62c8e0fba2de8c4c"
  API_call <- "https://api.openweathermap.org/data/2.5/forecast?lat=%s&lon=%s&appid=%s"
  complete_url <- sprintf(API_call, lat, lon, api_key)
  json <- fromJSON(complete_url)
  
  df <- data.frame(
    Time = json$list$dt_txt,
    Location = json$city$name,
    feels_like = json$list$main$feels_like - 273.2,
    temp_min = json$list$main$temp_min - 273.2,
    temp_max = json$list$main$temp_max - 273.2,
    pressure = json$list$main$pressure,
    sea_level = json$list$main$sea_level,
    grnd_level = json$list$main$grnd_level,
    humidity = json$list$main$humidity,
    temp_kf = json$list$main$temp_kf,
    temp = json$list$main$temp - 273.2,
    id = sapply(json$list$weather, function(entry) entry$id),
    main = sapply(json$list$weather, function(entry) entry$main),
    icon = sapply(json$list$weather, function(entry) entry$icon),
    weather_conditions = sapply(json$list$weather, function(entry) entry$description),
    speed = json$list$wind$speed,
    deg = json$list$wind$deg,
    gust = json$list$wind$gust
  )
  return(df)
}

server <- function(input, output, session) {
  default_lat <- 21.0124  # Latitude of Hanoi
  default_lon <- 105.5253 # Longitude of Hanoi
  weather_info <- get_weather_info(default_lat, default_lon)
  
  output$location <- renderText({ paste(weather_info$Location) })
  output$humidity <- renderText({ paste(weather_info$Humidity, "%") })
  output$temperature <- renderText({ paste(weather_info$Temperature, "°C") })
  output$feels_like <- renderText({ paste(weather_info$Feels_like, "°C") })
  output$weather_condition <- renderText({ paste(weather_info$WeatherCondition) })
  output$visibility <- renderText({ paste(weather_info$Visibility, "Km") })
  output$wind_speed <- renderText({ paste(weather_info$Wind_speed, "Km/h") })
  output$air_pressure <- renderText({ paste(weather_info$Air_pressure) })
  
  output$map <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>%
      setView(lng = default_lon, lat = default_lat, zoom = 15)
  })
  
  output$forecast_boxes <- renderUI({
    data <- get_forecast(default_lat, default_lon)
    
    forecast_boxes <- lapply(0:6, function(i) {
      day <- Sys.Date() + i
      temp_min <- round(data$temp_min[i + 1], 1)
      temp_max <- round(data$temp_max[i + 1], 1)
      weather_icon <- data$icon[i + 1]
      icon_url <- sprintf("https://openweathermap.org/img/wn/%s@2x.png", weather_icon)
      div(class = "forecast-box",
          tags$img(src = icon_url, alt = "Weather Icon", class = "forecast-icon", width = "50px", height = "50px"),
          p(format(as.Date(day), "%A, %d %B"), class = "forecast-temp"),
          p(paste(temp_max, "°C"), class = "forecast-temp"))
    })
    
    do.call(tags$div, c(class = "feature-row", forecast_boxes))
  })
  
  observeEvent(input$searchButton, {
    city <- input$searchText
    if (city != "") {
      weather_info <- get_weather_info_by_city(city)  
      forecast_data <- get_forecast(weather_info$Latitude, weather_info$Longitude)  
      
      output$location <- renderText({ paste(weather_info$Location) })
      output$humidity <- renderText({ paste(weather_info$Humidity, "%") })
      output$temperature <- renderText({ paste(weather_info$Temperature, "°C") })
      output$feels_like <- renderText({ paste(weather_info$Feels_like, "°C") })
      output$weather_condition <- renderText({ paste(weather_info$WeatherCondition) })
      output$visibility <- renderText({ paste(weather_info$Visibility, "Km") })
      output$wind_speed <- renderText({ paste(weather_info$Wind_speed, "Km/h") })
      output$air_pressure <- renderText({ paste(weather_info$Air_pressure) })
      
      output$map <- renderLeaflet({
        leaflet() %>%
          addTiles() %>%
          setView(lng = weather_info$Longitude, lat = weather_info$Latitude, zoom = 10)  
      })
      
      output$forecast_boxes <- renderUI({
        forecast_boxes <- lapply(1:7, function(i) {
          day <- Sys.Date() + i
          temp_min <- round(forecast_data$temp_min[i], 1)
          temp_max <- round(forecast_data$temp_max[i], 1)
          weather_icon <- forecast_data$icon[i]
          icon_url <- sprintf("https://openweathermap.org/img/wn/%s@2x.png", weather_icon)
          div(class = "forecast-box",
              tags$img(src = icon_url, alt = "Weather Icon", class = "forecast-icon", width = "50px", height = "50px"),
              p(format(as.Date(day), "%A, %d %B"), class = "forecast-temp"),
              p(paste(temp_max, "°C"), class = "forecast-temp"))
        })
        
        do.call(tags$div, c(class = "feature-row", forecast_boxes))
      })
    }
  })
  
  get_weather_info_by_city <- function(city) {
    api_key <- "a9cca8b2fb5c5dee62c8e0fba2de8c4c"
    city_encoded <- URLencode(city)  
    API_call <- "https://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s"
    complete_url <- sprintf(API_call, city_encoded, api_key)
    
    tryCatch({
      json <- fromJSON(complete_url)
      
      if (json$cod != 200) {
        stop("City not found")
      }
      
      location <- json$name
      lat <- json$coord$lat
      lon <- json$coord$lon
      temp <- json$main$temp - 273.2
      feels_like <- json$main$feels_like - 273.2
      humidity <- json$main$humidity
      weather_condition <- json$weather$description
      visibility <- json$visibility / 1000
      wind_speed <- json$wind$speed
      air_pressure <- json$main$pressure
      
      weather_info <- list(
        Location = location,
        Latitude = lat,
        Longitude = lon,
        Temperature = temp,
        Feels_like = feels_like,
        Humidity = humidity,
        WeatherCondition = weather_condition,
        Visibility = visibility,
        Wind_speed = wind_speed,
        Air_pressure = air_pressure
      )
      
      return(weather_info)
    }, error = function(e) {
      return(list(error = "City not found"))
    })
  }
  
  click <- NULL
  observeEvent(input$map_click, {
    click <<- input$map_click
    weather_info <<- get_weather_info(click$lat, click$lng)
    output$location <- renderText({ paste(weather_info$Location) })
    output$humidity <- renderText({ paste(weather_info$Humidity, "%") })
    output$temperature <- renderText({ paste(weather_info$Temperature, "°C") })
    output$feels_like <- renderText({ paste(weather_info$Feels_like, "°C") })
    output$weather_condition <- renderText({ paste(weather_info$WeatherCondition) })
    output$visibility <- renderText({ paste(weather_info$Visibility, "Km") })
    output$wind_speed <- renderText({ paste(weather_info$Wind_speed, "Km/h") })
  })
  
  observeEvent(input$feature, {
    output$location_ <- renderText({ paste('Location: ', weather_info$Location) })
    data <- get_forecast(default_lat, default_lon)
    output$line_chart <- renderPlotly({
      feature_data <- data[, c("Time", input$feature)]
      plot_ly(data = feature_data,
              x = ~Time,
              y = ~.data[[input$feature]],
              type = 'scatter',
              mode = 'lines+markers',
              name = input$feature) %>%
        layout(
          title = "Line Chart",
          xaxis = list(title = "Time"),
          yaxis = list(title = input$feature)
        ) %>%
        add_trace(
          line = list(color = "red"),
          marker = list(color = "black"),
          showlegend = FALSE
        )
    })
  })
}


