//
//  ViewController.swift
//  WeatherProj
//
//  Created by Julien Bankier on 5/25/17.
//  Copyright © 2017 Julien Bankier. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    private let dataManager = DataManager(baseURL: API.AuthenticatedBaseURL)

    
    fileprivate var aspectRatio: CGFloat {
        switch traitCollection.horizontalSizeClass {
        case .compact:
            return 1.0
        default:
            return 1.0 / 3.0
        }
    }
    
    fileprivate let minimumInteritemSpacingForSection: CGFloat = 0.0
    fileprivate let minimumLineSpacingForSection: CGFloat = 0.0
    fileprivate let insetForSection = UIEdgeInsets()
    
    enum RootViewType: Int {
        case now = 0
        case day
        case week
        
        static var count : Int{
            return RootViewType.week.rawValue + 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
       /* dataManager.weatherDataForLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude) { (response, error) in
            let weather = WeatherData(JSON: response)
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func setUpView(){
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(NowCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: NowCollectionViewCell.reuseIdentifier)
        collectionView.register(DayCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: DayCollectionViewCell.reuseIdentifier)
        collectionView.register(WeekCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: WeekCollectionViewCell.reuseIdentifier)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension RootViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RootViewType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // if no type then out
        guard let type = RootViewType(rawValue: indexPath.item) else {
            fatalError()
        }
        
        switch type {
        case .day:
            // Dequeue Reusable Cell
            return collectionView.dequeueReusableCell(withReuseIdentifier: NowCollectionViewCell.reuseIdentifier, for: indexPath)
        case .now:
            // Dequeue Reusable Cell
            return collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.reuseIdentifier, for: indexPath)
        case .week:
            // Dequeue Reusable Cell
            return collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.reuseIdentifier, for: indexPath)
        }
        
    }
    
}


extension RootViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        
        return CGSize(width: (bounds.width * aspectRatio), height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insetForSection
    }
    
}
