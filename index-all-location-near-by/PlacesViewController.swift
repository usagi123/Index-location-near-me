//
//  PlacesViewController.swift
//  index-all-location-near-by
//
//  Created by Mai Pham Quang Huy on 8/30/18.
//  Copyright © 2018 Mai Pham Quang Huy. All rights reserved.
//

import UIKit
import GooglePlaces
import SwiftyJSON

class PlacesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // An array to hold the list of possible locations.
    var likelyPlaces: [GMSPlace] = []
    var shopping_mall: [GMSPlace] = []
    var selectedPlace: GMSPlace?
    var lengthOfArray: Int = 0
    
    // Cell reuse id (cells that scroll out of view can be reused).
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopping_mall.removeAll()
        
        // Register the table view cell class and its reuse id.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller provides delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        lengthOfArray = likelyPlaces.count
        print(lengthOfArray)
        
        for i in 0..<likelyPlaces.count {
            print(likelyPlaces[i].name)
//            if !(likelyPlaces[i].types.contains("shopping_mall")) {
//                print(i)
//                print(likelyPlaces[i])
//            }
            
            if (likelyPlaces[i].types.contains("shopping_mall") && !shopping_mall.contains(likelyPlaces[i])) {
                shopping_mall.append(likelyPlaces[i])
            }
            
//            print(likelyPlaces)
        }
        likelyPlaces.removeAll()
        likelyPlaces = shopping_mall
//        print("LIKELYPLACES LIST:")
//        for i in 0..<likelyPlaces.count {
//            print(likelyPlaces[i].name)
//        }
//        print("SHOPPING MALL LIST")
//        for i in 0..<shopping_mall.count {
//            print(shopping_mall[i].name)
//        }
        tableView.reloadData()
//        print(lengthOfArray)
//        print(likelyPlaces)
    }
    
    // Pass the selected place to the new view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToMain" {
            if let nextViewController = segue.destination as? MapViewController {
                nextViewController.selectedPlace = selectedPlace
            }
        }
    }
}

// Respond when a user selects a place.
extension PlacesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlace = likelyPlaces[indexPath.row]
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
}

// Populate the table with the list of most likely places.
extension PlacesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likelyPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let collectionItem = likelyPlaces[indexPath.row]
        
        cell.textLabel?.text = collectionItem.name
        
        return cell
    }
    
    // Adjust cell height to only show the first five items in the table
    // (scrolling is disabled in IB).
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.size.height/5
    }
    
    // Make table rows display at proper height if there are less than 5 items.
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == tableView.numberOfSections - 1) {
            return 1
        }
        return 0
    }
}
