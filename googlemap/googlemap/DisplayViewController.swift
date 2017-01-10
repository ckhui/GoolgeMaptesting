//
//  DisplayViewController.swift
//  googlemap
//
//  Created by NEXTAcademy on 11/29/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import UIKit
import GoogleMaps

class DisplayViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: GMSMapView!
    var allowMaker = false
    var location : [CLLocationCoordinate2D] = []
    var merkers : [GMSMarker] = []
    var previousMakerLocation = CLLocationCoordinate2D()
    
    let path = GMSMutablePath()
    var polyline = GMSPolyline()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...10 {
            let templat = 48.858 + Double(i) * 0.001
            let templng = 2.294 + Double(i) * 0.001
            let position = CLLocationCoordinate2DMake(templat, templng)
            location.append(position)
            let marker = GMSMarker()
            marker.position = position
            marker.title = "loc: \(i)"
            marker.icon = GMSMarker.markerImage(with: UIColor.green)
            marker.tracksInfoWindowChanges = true
            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
            marker.map = mapView
            marker.userData = i
            merkers.append(marker)
            
        }
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        mapView.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: 48.858, longitude: 2.294, zoom:10.0)
        mapView.camera = camera
        
        drawRoute()
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addMarkerPressed(_ sender: AnyObject) {
        if allowMaker{
            print("quit marker added")
            for i in merkers{
                i.isDraggable = false
                i.icon = GMSMarker.markerImage(with: UIColor.green)
            }
            
        }
        else{
            print("longpress to add marker")
            for i in merkers{
                i.isDraggable = true
                i.icon = GMSMarker.markerImage(with: UIColor.red)
            }
        }
        
        allowMaker = !allowMaker
        
    }
    
    func drawRoute(){
        //overlay
        
        for i in location {
        path.add(i)
        }
        
        polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5.0
        polyline.strokeColor.withAlphaComponent(0.5)
        polyline.geodesic = true
        polyline.map = mapView

    }
    
}

extension DisplayViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return location.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            else{
                return UITableViewCell()
        }
        
        let info = location[indexPath.row]
        
        cell.textLabel?.text = "\(info.longitude) , \(info.latitude)"
        
        return cell
        
    }
}

extension DisplayViewController : GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("Tapped : \(coordinate) ")
        
        if allowMaker{
            
            let marker = GMSMarker()
            marker.position = coordinate
            marker.title = "added"
            marker.icon = GMSMarker.markerImage(with: UIColor.red)
            marker.tracksInfoWindowChanges = true
            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
            marker.map = mapView
            marker.isDraggable = true
            marker.userData = merkers.count
            
            merkers.append(marker)
            
            //add location and marker
            location.append(marker.position)
            
            tableView.reloadData()
            
            //allowMaker = false
            
            
            self.polyline.map = nil
            self.path.add(marker.position)
            self.polyline = GMSPolyline(path: self.path)
            //self.polyline.strokeWidth = 5.0
            //self.polyline.geodesic = true
            self.polyline.map = self.mapView
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("Tapped MArker : \(marker.title) at: \(marker.position)")
        
        mapView.selectedMarker = marker
        mapView.animate(toLocation: marker.position)
        return true
    }
    
    //    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
    //        print("Long Tapped : \(coordinate) ")
    //
    //    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("info window tapped:  \(marker.title)")
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        print("info window long tapped:  \(marker.title)")
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("begin drag")
        print("start: \(marker.position)")
        previousMakerLocation = marker.position
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("end drag")
        print("end: \(marker.position)")
        mapView.selectedMarker = marker
        
        askforMoveLocation(from: previousMakerLocation, marker: marker)
    }
    
    func askforMoveLocation(from previous:CLLocationCoordinate2D, marker: GMSMarker){
        
        //dotted line between 2 location
        //change alert to ui view /xib
        
        let alert = UIAlertController(title: "Move bus stop point", message: "Move from \(previous) to \(marker.position)", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "YES", style: .default) { (action) in
            let index = marker.userData as! Int
            self.location[index] = marker.position
            
            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .left)
            
            self.polyline.map = nil
            self.path.replaceCoordinate(at: UInt(index), with: marker.position)
            self.polyline = GMSPolyline(path: self.path)
            //self.polyline.strokeWidth = 5.0
            //self.polyline.geodesic = true
            self.polyline.map = self.mapView
            
        }
        
        let no = UIAlertAction(title: "NO", style: .default) { (action) in
            marker.position = previous
            
        }
        
        alert.addAction(yes)
        alert.addAction(no)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
}


