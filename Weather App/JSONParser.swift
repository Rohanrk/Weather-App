//
//  JSONParser.swift
//  Weather App
//
//  Created by Rohan Ramakrishnan on 11/8/16.
//  Copyright © 2016 Rohan Ramakrishnan. All rights reserved.
//

import SwiftyJSON

struct JSONParser {
    static func parseWeatherData(data: Any) -> WeatherData {
        let json = JSON(data)
        let currentWeather = json["currently"]
        var temperature: String!
        if let tempFloat = currentWeather["temperature"].float {
            temperature = String(format: "%.0f", tempFloat) + "°F"
        } else {
            temperature = ""
        }
        let description = currentWeather["summary"].string ?? ""
        let icon = currentWeather["icon"].string ?? ""
        return WeatherData(name: "", temperature: temperature, description: description, icon: icon)
    }
}
