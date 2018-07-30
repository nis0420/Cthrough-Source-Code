//
//  MainController.swift
//  ArCamera
//
//  Created by Nischal Panwala on 12/11/17.
//  Copyright © 2017 Nischal Panwala. All rights reserved.
//

import UIKit
import GoogleMaps

let kMapStyle = """
[
{
"elementType": "geometry",
"stylers": [
{
"color": "#f5f5f5"
}
]
},
{
"elementType": "labels.icon",
"stylers": [
{
"visibility": "off"
}
]
},
{
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#616161"
}
]
},
{
"elementType": "labels.text.stroke",
"stylers": [
{
"color": "#f5f5f5"
}
]
},
{
"featureType": "administrative",
"elementType": "geometry",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "administrative.land_parcel",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "administrative.land_parcel",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#bdbdbd"
}
]
},
{
"featureType": "administrative.neighborhood",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "poi",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "poi",
"elementType": "geometry",
"stylers": [
{
"color": "#eeeeee"
}
]
},
{
"featureType": "poi",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#757575"
}
]
},
{
"featureType": "poi.park",
"elementType": "geometry",
"stylers": [
{
"color": "#e5e5e5"
}
]
},
{
"featureType": "poi.park",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#9e9e9e"
}
]
},
{
"featureType": "road",
"elementType": "geometry",
"stylers": [
{
"color": "#ffffff"
}
]
},
{
"featureType": "road",
"elementType": "labels",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "road",
"elementType": "labels.icon",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "road.arterial",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#757575"
}
]
},
{
"featureType": "road.highway",
"elementType": "geometry",
"stylers": [
{
"color": "#dadada"
}
]
},
{
"featureType": "road.highway",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#616161"
}
]
},
{
"featureType": "road.local",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#9e9e9e"
}
]
},
{
"featureType": "transit",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "transit.line",
"elementType": "geometry",
"stylers": [
{
"color": "#e5e5e5"
}
]
},
{
"featureType": "transit.station",
"elementType": "geometry",
"stylers": [
{
"color": "#eeeeee"
}
]
},
{
"featureType": "water",
"elementType": "geometry",
"stylers": [
{
"color": "#c9c9c9"
}
]
},
{
"featureType": "water",
"elementType": "labels.text",
"stylers": [
{
"visibility": "off"
}
]
},
{
"featureType": "water",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#9e9e9e"
}
]
}
]
"""

class MainController: UIViewController, MotionSensorListenerDelegate, GPSLocationSensorListenerDelegate, GMSMapViewDelegate {

    let locationService = LocationService().getLocationServiceInstance()
    let motionSensor = MotionSensors()
    

    
    
    @IBOutlet weak var arButton: UIButton!
    @IBOutlet weak var mapUIView: GMSMapView!
    private var arMotionSensor : ARMotionSensor!
    private var _arLocation : ARLocation!
    private var _markers = [GMSMarker]()
    private var _markerToImageStructure = [GMSMarker : GoogleMapImageStructure]()
    private var _markerToUiImageStructure = [GMSMarker : UIImage]()
    let marker = GMSMarker()
    private var _zoom = Float()
    private var currentZoom : Float = -1
    var markerImages1 = GMSMarker()
    var widthMultiplier = 0.0
    var heightMultiplier = 0.0
    
    
    var uiImage = UIImage()
    
    var imageFromUrl = UIImage()
    //var mapView : GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        widthMultiplier = Double(self.view.frame.size.width) / 100
        heightMultiplier = Double(self.view.frame.size.height) / 568
        mapUIView.delegate = self
        //self.arButton = UIButton(type: .custom)
        self.arButton.frame = CGRect(x: UIScreen.main.bounds.width - 89, y: UIScreen.main.bounds.height - 116, width: 65, height: 65)
        self.arButton.setImage(UIImage(named: "Changed_AR_Button.png")! , for: .normal)
        self.arButton.contentMode = .center
        self.arButton.imageView?.contentMode = .scaleAspectFit
//        self.arButton.frame.origin = CGPoint(x: arButton.frame.origin.x * CGFloat(widthMultiplier), y: arButton.frame.origin.y * CGFloat(heightMultiplier))
        self.arButton.addTarget(self, action: #selector(arButtonTapped), for: .touchUpInside)
        
        do {
            // Set the map style by passing a valid JSON string.
            mapUIView.mapStyle = try GMSMapStyle(jsonString: kMapStyle)
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: UIScreen.main.bounds.width - 89, y: UIScreen.main.bounds.height - 196, width: 65, height: 65)
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "Changed_Location_button.png")!, for: .normal)
        button.addTarget(self, action: #selector(currentLocationButton), for: .touchUpInside)
        view.addSubview(button)

        locationService.setLocationSensorListenerDelegate(locationListenerDelegate: self)


        

        do{
            try motionSensor.start()
        } catch{
            print(error)
        }

        motionSensor.setMotionSensorListenerDelegate(motionSensorListenerDelegate: self)
        
        
        let googleMapDrawStructure = GoogleCustomMapService.getGoogleCustomMap()
        setGoogleMap(googleMapDrawStructure: googleMapDrawStructure)
        
        
        let image = self.resizeImage(image: UIImage(named: "location dot")!, targetSize: CGSize(width: 32, height: 32))

        marker.icon = image
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.map = mapUIView
        
    }
    
    @objc func arButtonTapped(sender: UIButton!) {
        locationService.removeLocationSensorListenerDelegate()
        motionSensor.removeMotionSensorListenerDelegate()
        locationService.stopUpdatingLocation()
        motionSensor.stop()
    }
    
    @objc func currentLocationButton(sender: UIButton!) {
        let camera = GMSCameraPosition.camera(withLatitude: _arLocation.currentLocation.coordinate.latitude, longitude: _arLocation.currentLocation.coordinate.longitude, zoom: 18)
        
        mapUIView.animate(to: camera)

    }
    
    private func setGoogleMap(googleMapDrawStructure : GoogleMapDrawStructure){
//        let camera = GMSCameraPosition.camera(withLatitude: googleMapDrawStructure.mapInfo.center.lat, longitude: googleMapDrawStructure.mapInfo.center.lng, zoom : googleMapDrawStructure.mapInfo.zoom)
//        print("zoome level from sever : \(googleMapDrawStructure.mapInfo.zoom)")
//        mapUIView.animate(to: camera)
        mapUIView.animate(toZoom: googleMapDrawStructure.mapInfo.zoom)
        
        let polygons = googleMapDrawStructure.data.polygons
        for poly in polygons{
            let paths = poly.paths
            
            let path = GMSMutablePath()
            
            for p in paths{
                path.add(CLLocationCoordinate2D(latitude: p.lat, longitude: p.lng))
            }
            
            let polygon = GMSPolygon(path: path)
            polygon.fillColor = hexStringToUIColor(hex: poly.fillColor)
            polygon.strokeColor = hexStringToUIColor(hex: poly.strokeColor)
            polygon.strokeWidth = CGFloat(Float(poly.strokeWeight)!)
            polygon.zIndex = Int32(poly.zIndex)
            polygon.geodesic = true
            polygon.map = mapUIView
        }
        
        
        let lines = googleMapDrawStructure.data.lines
        
        for line in lines{
            let paths = line.paths
            let path = GMSMutablePath()
            for p in paths{
                path.add(CLLocationCoordinate2D(latitude: p.lat, longitude: p.lng))
            }
            
            let polyLine = GMSPolyline(path: path)
            polyLine.strokeColor = hexStringToUIColor(hex: line.strokeColor)
            polyLine.strokeWidth = CGFloat(Float(line.strokeWeight)!)
            polyLine.zIndex = Int32(line.zIndex)
            polyLine.geodesic = true
            polyLine.map = mapUIView
        }
        
        for image in googleMapDrawStructure.data.images{
            let markerImages = GMSMarker()
            let position = CLLocationCoordinate2D(latitude: image.lat, longitude: image.lng)
            
            let zoom = 18
                let multiplier = Double(pow(2, Double(zoom - 18)))
                let width = Int(image.originalWidth * multiplier * image.scale)
                let height = Int(image.originalHeight * multiplier * image.scale)
                let queryParameter1 = QueryParameter()
                let data = WebApiCalls.sendGet(url: image.url, queryParameters: queryParameter1)
            guard UIImage(data: data.0!) != nil else {
                continue
            }
            self.imageFromUrl = UIImage(data: data.0!)!
            let scaledImage = self.resizeImage(image: self.imageFromUrl, targetSize: CGSize(width: width, height: height))
            markerImages.icon = scaledImage
            markerImages.position = position
            markerImages.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            self._markers.append(markerImages)
            self._markerToImageStructure[markerImages] = image
            self._markerToUiImageStructure[markerImages] = self.imageFromUrl
            markerImages1 = markerImages
            markerImages.map = self.mapUIView
        }
        
        for overlay in googleMapDrawStructure.data.overlays{
            let queryParameter1 = QueryParameter()
            let data = WebApiCalls.sendGet(url: overlay.url, queryParameters: queryParameter1)
            guard UIImage(data: data.0!) != nil else {
                continue
            }
            
            let icon = UIImage(data : data.0!)!
            
            let southWest = GMSGeometryOffset(CLLocationCoordinate2D(latitude :overlay.orginPoint.lat, longitude: overlay.orginPoint.lng), CLLocationDistance(overlay.height), 180)

            let northEast = GMSGeometryOffset(CLLocationCoordinate2D(latitude :overlay.orginPoint.lat, longitude: overlay.orginPoint.lng), CLLocationDistance(overlay.width), 90)

            let overlayBounds = GMSCoordinateBounds(coordinate: southWest, coordinate: northEast)

            let overlay = GMSGroundOverlay(bounds: overlayBounds, icon: icon)

            overlay.bearing = 0
            overlay.zIndex = 500
            overlay.map = self.mapUIView
        

        }
        
        
        
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
                self.imageFromUrl = UIImage(data: data)!
            
        }
        
    }
    
    func hasImageStructureProperty(key : GMSMarker) -> Bool{
        return self._markerToImageStructure[key] != nil
    }
    
    func getImageStructureProperty(key : GMSMarker) -> GoogleMapImageStructure!{
        if hasImageStructureProperty(key : key) {
            return self._markerToImageStructure[key]!
        }
        
        return nil
    }
    
    func hasUIImageStructureProperty(key : GMSMarker) -> Bool{
        return self._markerToUiImageStructure[key] != nil
    }
    
    func getUIImageStructureProperty(key : GMSMarker) -> UIImage!{
        if hasImageStructureProperty(key : key) {
            return self._markerToUiImageStructure[key]!
        }
        
        return nil
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
        
        if position.zoom != currentZoom{
            //let path = GMSMutablePath()
            for mark in self._markers{
                let imageStructure = getImageStructureProperty(key: mark)

                let zoom = position.zoom
                let multiplier = Double(pow(2, Double(zoom - 17)))

                var width = Int(imageStructure!.originalWidth * multiplier * imageStructure!.scale)
                var height = Int(imageStructure!.originalHeight * multiplier * imageStructure!.scale)

                if width < 1{
                    width = 1
                }
                
                if height < 1 {
                    height = 1
                }

                uiImage = getUIImageStructureProperty(key: mark)

                let scaledImage = self.resizeImage(image: uiImage, targetSize: CGSize(width: width, height: height))
                mark.icon = scaledImage
            }
            currentZoom = position.zoom
        }
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func GPSLocationAvailable(location: ARLocation) {
        if _arLocation == nil{
            let camera = GMSCameraPosition.camera(withLatitude: location.currentLocation.coordinate.latitude, longitude: location.currentLocation.coordinate.longitude, zoom: 18)
            mapUIView.animate(to: camera)
        }
        _arLocation = location
        marker.position = location.currentLocation.coordinate
    }
    

    
    func motionSensorAvailable(motionSensor: ARMotionSensor) {
        arMotionSensor = motionSensor
        marker.rotation = arMotionSensor.compass.radiansToDegrees + 270
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        if Int(targetSize.width) < 1 || Int(targetSize.height) < 1{
            return UIImage()
        }
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    
}

