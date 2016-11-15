//
//  WeatherViewController.swift
//  Weather App
//
//  Created by Rohan Ramakrishnan on 11/8/16.
//  Copyright © 2016 Rohan Ramakrishnan. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var weatherLocation: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = String(format: "%.2f", location.coordinate.latitude)
            let longitude = String(format: "%.2f", location.coordinate.longitude)
            getWeather(latitude: latitude, longitude: longitude)
            reverseGeocoding(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
    
    func getWeather(latitude: String, longitude: String) {
        DarkSkyService.weatherForCoordinates(latitude: latitude, longitude: longitude, completion: { data, error in
            if let _ = error {
                self.showErrorAlerts()
            } else if let weather = data {
                self.temperature.text = weather.temperature
                self.weatherDescription.text = weather.description
                self.weatherIcon.text = weather.icon.getEmoji()
            }
        })
    }
    
    func reverseGeocoding(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if let _ = error {
                self.weatherLocation.text = ""
            } else if let placemarks = placemarks {
                let pm = placemarks[0]
                let city = pm.locality ?? ""
                self.weatherLocation.text = city
            }
        })
        
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        locationManager.requestLocation()
    }
    
    func showErrorAlerts() {
        let alert = UIAlertController(title: "Oops!", message: "Something went wrong, please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension String {
    /// Get a forecast icon's corresponding emoji
    func getEmoji() -> String {
        switch self {
        case "clear-day":
            return "☀️"
        case "clear-night":
            return "🌙"
        case "rain":
            return "☔️"
        case "snow":
            return "❄️"
        case "sleet":
            return "🌨"
        case "wind":
            return "🌬"
        case "fog":
            return "🌫"
        case "cloudy":
            return "☁️"
        case "partly-cloudy-day":
            return "🌤"
        case "partly-cloudy-night":
            return "🌥"
        default:
            return "❓"
        }
    }
}
