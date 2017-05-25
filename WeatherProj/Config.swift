//
//  Config.swift
//  WeatherProj
//
//  Created by Julien Bankier on 5/25/17.
//  Copyright © 2017 Julien Bankier. All rights reserved.
//

import Foundation

struct API {
    static let APIKey = "ed80daa21f6ea35ff7b89eca5fa9ebca"
    static let BaseURL = URL(string: "https://api.forecast.io/forecast/")!
    
    static var AuthenticatedBaseURL: URL {
        return BaseURL.appendingPathComponent(APIKey)
    }
}

struct Defaults {
    static let Latitude: Double = 37.8267
    static let Longitude: Double = -122.423
}
