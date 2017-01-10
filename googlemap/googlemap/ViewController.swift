//
//  ViewController.swift
//  googlemap
//
//  Created by NEXTAcademy on 11/28/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {


    @IBOutlet weak var panoView: GMSPanoramaView!
    @IBOutlet weak var mapUIView: GMSMapView!
    
    let infoMarker = GMSMarker()
    
    
    // Paste the JSON string to use.
    let kMapStyle2 = "[" +
        "  {" +
        "    \"featureType\": \"poi.business\"," +
        "    \"elementType\": \"all\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"visibility\": \"off\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"transit\"," +
        "    \"elementType\": \"labels.icon\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"visibility\": \"off\"" +
        "      }" +
        "    ]" +
        "  }" +
    "]"
    
    let kMapStyle1 = "[" +
    "  {" +
    "    \"featureType\": \"all\"," +
    "    \"elementType\": \"geometry\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#242f3e\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"all\"," +
    "    \"elementType\": \"labels.text.stroke\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"lightness\": -80" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"administrative\"," +
    "    \"elementType\": \"labels.text.fill\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#746855\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"administrative.locality\"," +
    "    \"elementType\": \"labels.text.fill\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#d59563\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"poi\"," +
    "    \"elementType\": \"labels.text.fill\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#d59563\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"poi.park\"," +
    "    \"elementType\": \"geometry\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#263c3f\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"poi.park\"," +
    "    \"elementType\": \"labels.text.fill\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#6b9a76\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"road\"," +
    "    \"elementType\": \"geometry.fill\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#2b3544\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"road\"," +
    "    \"elementType\": \"labels.text.fill\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#9ca5b3\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"road.arterial\"," +
    "    \"elementType\": \"geometry.fill\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#38414e\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"road.arterial\"," +
    "    \"elementType\": \"geometry.stroke\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#212a37\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"road.highway\"," +
    "    \"elementType\": \"geometry.fill\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#746855\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"road.highway\"," +
    "    \"elementType\": \"geometry.stroke\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#1f2835\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"road.highway\"," +
    "    \"elementType\": \"labels.text.fill\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#f3d19c\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"road.local\"," +
    "    \"elementType\": \"geometry.fill\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#38414e\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"road.local\"," +
    "    \"elementType\": \"geometry.stroke\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#212a37\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"transit\"," +
    "    \"elementType\": \"geometry\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#2f3948\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"transit.station\"," +
    "    \"elementType\": \"labels.text.fill\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#d59563\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"transit.station\"," +
    "    \"elementType\": \"labels.text.fill\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#d59563\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"water\"," +
    "    \"elementType\": \"labels.text.fill\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"color\": \"#515c6d\"" +
    "      }" +
    "    ]" +
    "  }," +
    "  {" +
    "    \"featureType\": \"water\"," +
    "    \"elementType\": \"labels.text.stroke\"," +
    "    \"stylers\": [" +
    "      {" +
    "        \"lightness\": -20" +
    "      }" +
    "    ]" +
    "  }" +
    "]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let camera = GMSCameraPosition.camera(withLatitude: 48.858, longitude: 2.294, zoom:13.0)
        mapUIView.camera = camera
        
        
        //mapUIView.isMyLocationEnabled = true
        //mapUIView = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 48.858, longitude: 2.294)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.icon = GMSMarker.markerImage(with: UIColor.black)
        marker.isFlat = true
        marker.map = mapUIView
        //marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        //marker.rotation = 90.0
        marker.tracksInfoWindowChanges = true
        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        
        //mapUIView.mapType = kGMSTypeNormal
        mapUIView.accessibilityElementsHidden = false
        mapUIView.isMyLocationEnabled = true
        mapUIView.delegate = self
        
        mapUIView.settings.compassButton = true
        mapUIView.settings.myLocationButton = true
        mapUIView.settings.indoorPicker = false
        
        if let mylocation = mapUIView.myLocation {
            print("User's location: \(mylocation)")
        } else {
            print("User's location is unknown")
        }
        
        //let mapInsets = UIEdgeInsets(top: 100.0, left: 0.0, bottom: 0.0, right: 300.0)
        //mapUIView.padding = mapInsets
        
//        do {
//            // Set the map style by passing the URL of the local file.
//            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
//                mapUIView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
//            } else {
//                NSLog("Unable to find style.json")
//            }
//        } catch {
//            NSLog("The style definition could not be loaded: \(error)")
//        }
        
        do {
            // Set the map style by passing a valid JSON string.
            mapUIView.mapStyle = try GMSMapStyle(jsonString: kMapStyle1)
        } catch {
            NSLog("The style definition could not be loaded: \(error)")
        }

        
        
        panoView.moveNearCoordinate(CLLocationCoordinate2D(latitude: 48.858, longitude: 2.294))
        panoView.camera = GMSPanoramaCamera(heading: 180, pitch: -10, zoom: 1)
        
//        panoView.orientationGestures = true
//        panoView.navigationGestures = true
//        panoView.zoomGestures = true
        panoView.setAllGesturesEnabled(true)
        
        let position = CLLocationCoordinate2D(latitude: 48.858, longitude: 2.294)
        let marker2 = GMSMarker(position: position)
        marker2.panoramaView = panoView
        //marker2.map = mapUIView
        
        
        //overlay
        let path = GMSMutablePath()
        path.addLatitude(48.858, longitude: 2.294)
        path.addLatitude(48.860, longitude: 2.294)
        path.addLatitude(48.860, longitude: 2.296)
        path.addLatitude(48.858, longitude: 2.296)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 10.0
        polyline.geodesic = true
        polyline.map = mapUIView
        
        let solidRed = GMSStrokeStyle.solidColor(UIColor.red)
        let gradientRedToYellow = GMSStrokeStyle.gradient(from: UIColor.red, to: UIColor.yellow)
        polyline.spans = [GMSStyleSpan(style: solidRed, segments: 1.2), GMSStyleSpan(style: gradientRedToYellow, segments: 5)]
        
        //let styles = [GMSStrokeStyle.solidColor(UIColor.white),
        //              GMSStrokeStyle.solidColor(UIColor.black)]
        //let lengths : [NSNumber] = [10, 50]
        //polyline.spans = GMSStyleSpans(polyline.path!, styles, lengths, kGMSLengthRhumb)
        
        
        // Create the polygon, and assign it to the map.
        let polygon = GMSPolygon(path: path)
        polygon.fillColor = UIColor(red: 0.25, green: 0, blue: 0, alpha: 0.05);
        polygon.strokeColor = UIColor.blue
        polygon.strokeWidth = 2
        polygon.fillColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.8, alpha: 0.2)
        polygon.map = mapUIView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : GMSMapViewDelegate{

    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        print("You tapped \(name): \(placeID), \(location.latitude)/\(location.longitude)")
        
        infoMarker.snippet = placeID
        infoMarker.position = location
        infoMarker.title = name
        infoMarker.opacity = 0;
        infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = mapView
        mapUIView.selectedMarker = infoMarker
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")

    }
    
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        let geocoder = GMSGeocoder()
//        let handler = { (response: GMSReverseGeocodeResponse?, error: NSError?) -> Void in
//            guard error == nil else {
//                return
//            }
//            
//            if let result = response?.firstResult() {
//                let marker = GMSMarker()
//                marker.position = position.target
//                marker.title = result.lines?[0]
//                marker.snippet = result.lines?[1]
//                marker.map = mapView
//            }
//        }
//        geocoder.reverseGeocodeCoordinate(position.target, completionHandler: handler as! GMSReverseGeocodeCallback)
//    }
}

