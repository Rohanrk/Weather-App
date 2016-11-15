//
//  DarkSkyService.swift
//  Weather App
//
//  Created by Rohan Ramakrishnan on 11/8/16.
//  Copyright © 2016 Rohan Ramakrishnan. All rights reserved.
//

import Alamofire

public struct DarkSkyService {
    private static let baseUrl = "https://api.darksky.net/forecast/"
    private static let apiKey = "725fa1cbe3c4e5c6576f04ed217acb1b"
    
    static func weatherForCoordinates(latitude: String, longitude: String, completion: @escaping(WeatherData?, Error?) -> Void) {
        let url = baseUrl + "\(apiKey)/\(latitude),\(longitude)"
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success:
                print("Success!")
                let weather = JSONParser.parseWeatherData(data: response.result.value!)
                completion(weather, nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
        
    }
    
}
