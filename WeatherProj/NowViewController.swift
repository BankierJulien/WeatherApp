//
//  NowViewController.swift
//  WeatherProj
//
//  Created by Julien Bankier on 5/25/17.
//  Copyright © 2017 Julien Bankier. All rights reserved.
//

import UIKit

class NowViewController: UIViewController {
    private let dataManager = DataManager(baseURL: API.AuthenticatedBaseURL)
    let currentTemp = UILabel(frame: CGRect(x: 100, y: 100, width: 1000, height: 1000))

    // calling data on main thread
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.weatherDataForLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude) { (response, error) in
            let weather = WeatherData(JSON: response)
            // get current time, find the one that corresponds, and display it
            let temp = weather?.hourData[0].temperature
            let tempString = String(describing: temp)
            self.currentTemp.text = tempString
            self.setUpView()
        }
       
        self.view.backgroundColor = UIColor.gray

    }
    
    override func viewDidAppear(_ animated: Bool) {
         setUpView()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpView(){
        
        self.view.addSubview(currentTemp)
        
    }
    



}
