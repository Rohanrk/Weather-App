//
//  WeatherData.swift
//  Weather App
//
//  Created by Rohan Ramakrishnan on 11/8/16.
//  Copyright © 2016 Rohan Ramakrishnan. All rights reserved.
//

import Foundation

struct WeatherData {
    
    var name: String
    var temperature: String
    var description: String
    var icon: String
    
    init(name: String, temperature: String, description: String, icon: String) {
        self.name = name
        self.temperature = temperature
        self.description = description
        self.icon = icon
    }
    
    
}
