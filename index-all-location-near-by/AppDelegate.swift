//
//  AppDelegate.swift
//  index-all-location-near-by
//
//  Created by Mai Pham Quang Huy on 8/30/18.
//  Copyright © 2018 Mai Pham Quang Huy. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSPlacesClient.provideAPIKey("AIzaSyBhgyEAqwxMs2_xP9J5mLABFe2QmI-z70o") //Google place api key
        GMSServices.provideAPIKey("AIzaSyBhgyEAqwxMs2_xP9J5mLABFe2QmI-z70o") //Google map api key
        return true
    }
}

