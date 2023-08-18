// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherData = try? JSONDecoder().decode(WeatherData.self, from: jsonData)

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let weather: [Weather]
    let dt: Int
    let name: String
    let wind: Wind
    let main: Main
    let coord: Coord
    let sys: Sys
    let base: String
    let visibility, timezone, cod: Int
    let clouds: Clouds
    let id: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let pressure: Int
    let tempMin: Double
    let grndLevel, humidity: Int
    let tempMax, feelsLike, temp: Double
    let seaLevel: Int

    enum CodingKeys: String, CodingKey {
        case pressure
        case tempMin = "temp_min"
        case grndLevel = "grnd_level"
        case humidity
        case tempMax = "temp_max"
        case feelsLike = "feels_like"
        case temp
        case seaLevel = "sea_level"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunrise: Int
    let country: String
    let id, sunset, type: Int
}

// MARK: - Weather
struct Weather: Codable {
    let description: String
    let id: Int
    let icon, main: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed, gust: Double
    let deg: Int
}
