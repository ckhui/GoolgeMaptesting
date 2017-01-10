//
//  MainPageViewController.swift
//  googlemap
//
//  Created by NEXTAcademy on 11/30/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MainPageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: GMSMapView!
    

    
    let currentLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(3.1349378, 101.6299155)
    let currentLocationMarker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        
        tableView.delegate = self
        tableView.dataSource = self
        
        let camera = GMSCameraPosition.camera(withTarget: currentLocation, zoom: 15.0)
        mapView.camera = camera
        
        currentLocationMarker.position = currentLocation
        currentLocationMarker.title = "You Are Here"
        currentLocationMarker.icon = GMSMarker.markerImage(with: UIColor.black)
        currentLocationMarker.map = mapView
        
        mapView.selectedMarker = currentLocationMarker
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MainPageViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            else{ return UITableViewCell() }
        
        return cell
    }
}


