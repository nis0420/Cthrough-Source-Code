//
//  ARLocationTagScene.swift
//  Cthrough
//
//  Created by Nischal Panwala on 2/28/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import SceneKit
import GoogleMaps
import AVFoundation
import AVKit

class ARLocationTagScene: ARScene, GPSLocationSensorListenerDelegate, OnClickListenerDelegate {
    func OnClick(view : UIView!, text: String, sceneVec : SCNVector3) {
        isTagClicked = true
        eventButton.isHidden = true
        mapUiButton.isHidden = true
        let getLocationTagStructure = getProperty(key: text)
        
        let DynamicView=UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 500))
        DynamicView.center.x = view.center.x
        DynamicView.center.y = view.center.y
        DynamicView.tag = 100
        
        let exitButton = UIButton(type: .custom)
        
        exitButton.contentMode = .center
        exitButton.imageView?.contentMode = .scaleAspectFit

        exitButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let label: UILabel = UILabel()
        label.frame = CGRect(x: 50, y: 300, width: 200, height: 21)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.text = getLocationTagStructure?.description
        
        let imageFlamingoPond = UIImage(named: "Flamingo_Pond.png")
        let flamingoPondUiImageView = UIImageView(image: imageFlamingoPond!)
        flamingoPondUiImageView.contentMode = .scaleAspectFit
        flamingoPondUiImageView.frame = CGRect(x: 51, y: 150, width: DynamicView.frame.size.width - 100, height: 300)
        
        let imageWindsOfWonder = UIImage(named: "Wings_Of_Wonder.png")
        let WindsOfWonderUiImageView = UIImageView(image: imageWindsOfWonder!)
        WindsOfWonderUiImageView.contentMode = .scaleAspectFit
        WindsOfWonderUiImageView.frame = CGRect(x: 51, y: 150, width: DynamicView.frame.size.width - 100, height: 300)
        
        let imageCatGreenField = UIImage(named: "Cat_Green_Field.png")
        let catGreenFieldUiImageView = UIImageView(image: imageCatGreenField!)
        catGreenFieldUiImageView.contentMode = .scaleAspectFit
        catGreenFieldUiImageView.frame = CGRect(x: 51, y: 150, width: DynamicView.frame.size.width - 100, height: 300)
        
        let imageSumatranTigerField = UIImage(named: "Sumatran_Tiger.png")
        let sumatranTigerFieldUiImageView = UIImageView(image: imageSumatranTigerField!)
        sumatranTigerFieldUiImageView.contentMode = .scaleAspectFit
        sumatranTigerFieldUiImageView.frame = CGRect(x: 51, y: 150, width: DynamicView.frame.size.width - 100, height: 300)

        
        let imagePrimeMaridianCafeField = UIImage(named: "Prime_Changed.png")
        let primeMaridianCafeFieldUiImageView = UIImageView(image: imagePrimeMaridianCafeField!)
        primeMaridianCafeFieldUiImageView.contentMode = .scaleAspectFit
        primeMaridianCafeFieldUiImageView.frame = CGRect(x: 51, y: 150, width: DynamicView.frame.size.width - 100, height: 300)
        
        var imageEvent = UIImage()
        
        if getLocationTagStructure?.fullname == "Flamingo Pond event"{
            imageEvent = UIImage(named: "Flamingo_Event.png")!
        }
        if getLocationTagStructure?.fullname == "Winds of Wonder event"{
            imageEvent = UIImage(named: "Wings_Of_Wonder_Event.png")!
        }
        if getLocationTagStructure?.fullname == "Cat Green Pavilion event"{
            imageEvent = UIImage(named: "Wondering_Of_The _Wild_Show.png")!
        }
        if getLocationTagStructure?.fullname == "Sumatran Tiger event"{
            imageEvent = UIImage(named: "Tiger_Event.png")!
        }
        
        let eventUiImageView = UIImageView(image: imageEvent)
        eventUiImageView.center = CGPoint(x: DynamicView.frame.size.width  / 2, y: DynamicView.frame.size.height / 2)
        eventUiImageView.frame = CGRect(x: 38, y: 90, width: DynamicView.frame.size.width - 93, height: 300)
        eventUiImageView.contentMode = .scaleAspectFit
        
        
        let flamingoGif = UIImage.gifImageWithName("Emotion_FerrisWheel")
        let imageViewGif = UIImageView(image: flamingoGif)
        imageViewGif.contentMode = .scaleAspectFit
        imageViewGif.frame = CGRect(x: 20.0, y: 25, width: DynamicView.frame.size.width - 28, height: 200)
        
        let tigerGif = UIImage.gifImageWithName("tigerGif")
        let tigerImageViewGif = UIImageView(image: tigerGif)
        tigerImageViewGif.contentMode = .scaleAspectFit
        tigerImageViewGif.frame = CGRect(x: 20.0, y: 25, width: DynamicView.frame.size.width - 28, height: 200)
        //--------------- State Fair Image--------
        let cottonBowlImage = UIImage(named: "Cotton_Bowl_Stadium_New.png")
        let cottonBowlUiImageView = UIImageView(image: cottonBowlImage!)
        cottonBowlUiImageView.contentMode = .scaleAspectFit
        cottonBowlUiImageView.frame = CGRect(x: DynamicView.frame.size.width / 2 - 220, y: DynamicView.frame.size.height / 2 - 265, width: 440, height: 440)
        
        let hipsterImage = UIImage(named: "hipster-big-tex.png")
        let hipsterUiImageView = UIImageView(image: hipsterImage!)
        hipsterUiImageView.contentMode = .scaleAspectFit
        hipsterUiImageView.frame = CGRect(x: 0, y: 15, width: DynamicView.frame.size.width - 28, height: 200)
        
        let parrotGif = UIImage.gifImageWithName("Parrot_Gif")
        let parrotImageViewGif = UIImageView(image: parrotGif)
        parrotImageViewGif.contentMode = .scaleAspectFit
        parrotImageViewGif.frame = CGRect(x: 20.0, y: -10, width: DynamicView.frame.size.width - 40, height: 250)
        
        let primeMeridianGif = UIImage.gifImageWithName("Prime_Meridian_Cafe_Gif")
        let primeMeridianViewGif = UIImageView(image: primeMeridianGif)
        primeMeridianViewGif.contentMode = .scaleAspectFit
        primeMeridianViewGif.frame = CGRect(x: 20.0, y: 25, width: DynamicView.frame.size.width - 28, height: 200)
        
        let treasureBoxGif = UIImage.gifImageWithName("Treasure_Box_Gif")
        let treasureBoxViewGif = UIImageView(image: treasureBoxGif)
        treasureBoxViewGif.contentMode = .scaleAspectFit
        treasureBoxViewGif.frame = CGRect(x: 0, y: 15, width: DynamicView.frame.size.width - 28, height: 200)
        
        if getLocationTagStructure?.buildingType == "Changed_Event_Tag"{
            exitButton.frame = CGRect(x: 45, y: 135, width: 65, height: 65)
            exitButton.backgroundColor = UIColor.clear
                DynamicView.addSubview(eventUiImageView)
        }else if getLocationTagStructure?.buildingType == "Treasure_Box"{
            let treasureBoxGif = UIImage.gifImageWithName("Treasure_Box_1")
            let imageViewGif = UIImageView(image: treasureBoxGif)
            imageViewGif.center.x = CGFloat(Double(sceneVec.x) - Double(imageViewGif.frame.width / 2) + 84)
            imageViewGif.center.y = CGFloat(Double(sceneVec.y) - Double(imageViewGif.frame.height / 2) + 75)
            imageViewGif.contentMode = .scaleAspectFit
            imageViewGif.clipsToBounds = true
            imageViewGif.tag = 120
            
            Timer.scheduledTimer(timeInterval: 0.20, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
            view.addSubview(imageViewGif)
            
        }else if getLocationTagStructure?.buildingType == "General School Building"{
            exitButton.frame = CGRect(x: 186, y: 380, width: 28, height: 28)
            exitButton.setImage(UIImage(named: "Close_Button.png")!, for: .normal)
            if getLocationTagStructure?.fullname == "Flamingo Pond"{
            DynamicView.addSubview(flamingoPondUiImageView)
            DynamicView.addSubview(imageViewGif)
            }
            if getLocationTagStructure?.fullname == "Winds of Wonder"{
                DynamicView.addSubview(cottonBowlUiImageView)            }
            if getLocationTagStructure?.fullname == "Cat Green Pavilion"{
                DynamicView.addSubview(catGreenFieldUiImageView)
                DynamicView.addSubview(hipsterUiImageView)
            }
            if getLocationTagStructure?.fullname == "Sumatran Tiger"{
                DynamicView.addSubview(sumatranTigerFieldUiImageView)
                DynamicView.addSubview(tigerImageViewGif)
            }
            if getLocationTagStructure?.fullname == "Prime Meridian Cafe"{
                DynamicView.addSubview(primeMaridianCafeFieldUiImageView)
                DynamicView.addSubview(primeMeridianViewGif)
            }
        }
        
        DynamicView.addSubview(exitButton)
        
        
        view.addSubview(DynamicView)
        custView = view
    }
    
    @objc func runTimedCode(sender: UIButton!) {
        if let viewWithTag = custView.viewWithTag(120) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
        
        eventButton.isHidden = true
        
        let DynamicView=UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        DynamicView.backgroundColor = UIColor(displayP3Red: 0.2, green: 0.2, blue: 0.2, alpha: 0.7)
        DynamicView.tag = 200
        
        var avPlayer: AVPlayer!
        
        let filepath: String? = Bundle.main.path(forResource: "My Movie SF", ofType: "mp4")
        let fileURL = URL.init(fileURLWithPath: filepath!)
        
        
        avPlayer = AVPlayer(url: fileURL)
        
        
        let avPlayerController = AVPlayerViewController()
        avPlayerController.player = avPlayer
        avPlayerController.view.frame = CGRect(x: DynamicView.frame.width / 2 - 150, y: DynamicView.frame.height / 2 - 150, width:300, height:300)
        avPlayerController.view.backgroundColor = UIColor.clear
        //  hide show control
        avPlayerController.showsPlaybackControls = false
        // play video
        
        avPlayerController.player?.play()
        
        let rectangleVideoUiView = UIImage(named: "Rectangle_Video.png")
        let rectangleVideoImageView = UIImageView(image: rectangleVideoUiView!)
        rectangleVideoImageView.frame = CGRect(x: DynamicView.frame.width / 2 - 165, y: DynamicView.frame.height / 2 - 100, width:330, height:200)


        let exitButton = UIButton(type: .custom) 
        
        exitButton.contentMode = .center
        exitButton.imageView?.contentMode = .scaleAspectFit
        exitButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        exitButton.frame = CGRect(x: DynamicView.frame.width / 2 + 133, y: DynamicView.frame.height / 2 - 168, width: 40, height: 40)
        exitButton.setImage(self.resizeImage(image: UIImage(named: "TBCloseButton.png")!, targetSize: CGSize(width: 70, height: 70)) , for: .normal)

        DynamicView.addSubview(exitButton)
        DynamicView.addSubview(rectangleVideoImageView)
        DynamicView.addSubview(avPlayerController.view)
        custView.addSubview(DynamicView)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        isTagClicked = false
        if let viewWithTag = custView.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
        
        if let viewWithTag = custView.viewWithTag(200) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
        
        if eventButton.isHidden {
            eventButton.isHidden = false
        }else{
            eventButton.isHidden = true
        }
        
        if mapUiButton.isHidden {
            mapUiButton.isHidden = false
        }else{
            mapUiButton.isHidden = true
        }
        
        
        if !isEventMode{
//            for nd in self.treasureBoxNodes{
//                self.nodes.append(nd)
//                self.eventNodes.append(nd)
//            }
            ViewController.setNodes(nodes: nodes)
        }else{
            mapUiButton.isHidden = true
            ViewController.setNodes(nodes: eventNodes)
        }
    }
    
    func addEventButton(view : UIView!, mapButton : UIButton){
         // let preferred over var here
        mapUiButton = mapButton
        eventButton.frame = CGRect(x: UIScreen.main.bounds.width - 89, y: UIScreen.main.bounds.height - 196, width: 62, height: 62)
        
        eventButton.contentMode = .center
        eventButton.imageView?.contentMode = .scaleAspectFit
        eventButton.setImage(UIImage(named: "EventButton.png")!, for: .normal)
        eventButton.addTarget(self, action: #selector(eventButtonClicked), for: .touchUpInside)
        
        view.addSubview(eventButton)
    }
    
    @objc func eventButtonClicked(sender: UIButton!) {
        if !isEventMode{
            isEventMode = true
            mapUiButton.isHidden = true
            eventButton.frame = CGRect(x: UIScreen.main.bounds.width - 89, y: UIScreen.main.bounds.height - 116, width: 62, height: 62)
            ViewController.setNodes(nodes: eventNodes)
            eventButton.setImage(UIImage(named: "Changed_Exit_Button.png")!, for: .normal)
            
            
        }else{
            isEventMode = false
            mapUiButton.isHidden = false
            eventButton.frame = CGRect(x: UIScreen.main.bounds.width - 89, y: UIScreen.main.bounds.height - 196, width: 62, height: 62)
            ViewController.setNodes(nodes: nodes)
            eventButton.setImage(UIImage(named: "EventButton.png")!, for: .normal)
        }
    }
    
    public static func findDistance(distance : CLLocationDistance) -> Float{

        
        return MIN_OPENGL_DISTANCE + Float(distance) * (MAX_OPENGL_DISTANCE - MIN_OPENGL_DISTANCE) / MAX_ACTUAL_DISTANCE
    }
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 12)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            ] as [NSAttributedStringKey : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func addProperty(key : String, value : LocationTagStructure){
        _properties[key] = value
    }
    
    func hasProperty(key : String) -> Bool{
        return _properties[key] != nil
    }
    
    func getProperty(key : String) -> LocationTagStructure!{
        if hasProperty(key : key) {
            return _properties[key]!
        }
        
        return nil
    }
    var actualDistance2 = CLLocationDistance()
    func getArLocationTagNode(locationTagStructure : LocationTagStructure) -> ARLocationTagNode! {
        if !hasProperty(key: locationTagStructure.fullname){
            addProperty(key: locationTagStructure.fullname, value: locationTagStructure)
            
        }
        
        let convertedToClLocation =  ARLocation.convertToCllocation(latitude: locationTagStructure.latitude, longitude: locationTagStructure.longitude)
        
        bearing = Float(ARLocation.getBearingBetweenTwoPoints1(point1: (arLocation?.currentLocation)!, point2: convertedToClLocation))
        actualDistance2 = (arLocation?.currentLocation.distance(from: convertedToClLocation))!
        if locationTagStructure.name == "Admin Building"{
            if (self.actualDistance2.isLess(than: 100)){
                self.actualDistance2 = 0
            }
        }
       
        let openGlDistance = ARLocationTagScene.findDistance(distance: actualDistance2)
        
        
        let locationTag = ARLocationTagNode(image: locationTagStructure.buildingType, title: locationTagStructure.name, description: locationTagStructure.description, distance : Float(actualDistance2), fullName : locationTagStructure.fullname)
        
        locationTag.create()
        let elevateDistance = findElevateDistance(actualDistance: Float(actualDistance2), openGlDistance: openGlDistance)
        
        
        let x = sin(locationPitch.degreesToRadians) * sin(bearing.degreesToRadians) * openGlDistance
        let y = (cos(locationPitch.degreesToRadians) * openGlDistance) - elevateDistance
        let z = sin(locationPitch.degreesToRadians) * cos(bearing.degreesToRadians) * openGlDistance
        
        let position : SCNVector3 = SCNVector3(x:-x,y:-y,z:z)
        //let eulerAngle : SCNVector3 = SCNVector3(x:0, y: -bearing, z:0)
        
        locationTag.setPosition(positions: position)
        return locationTag
    }
    

    
    func GPSLocationAvailable(location: ARLocation) {
        
          //  location.currentLocation = CLLocation(latitude: 32.77845, longitude: -96.75830)
            let actualDistance1 = arLocation?.currentLocation.distance(from: (location.currentLocation))
            if arLocation == nil || Float(actualDistance1!) > ARLocationTagScene.MIN_UPDATE_DISTANCE
            {
                //print("Location in GpsLocationAvailable delegat : \(location.currentLocation)")
                arLocation = location
                DispatchQueue.global(qos: .default).async {
                    self.locationTagStructures = self.getNearbyLocations()
                    self.eventTagStructure = self.getNearByEvent()
                    self.treasureboxStructure = self.getNearByTresureBox()
                    
                
                    self.nodes.removeAll()
                    self.eventNodes.removeAll()
                    //self.treasureBoxNodes.removeAll()
                    for locTagStruc in self.locationTagStructures{
                        let arLocationTagNode = self.getArLocationTagNode(locationTagStructure: locTagStruc)
                    //locationTag.setEulerAngle(eulerAngle: eulerAngle)
                        //if (self.actualDistance2.isLess(than: 50)){
                        self.nodes.append(arLocationTagNode!)
                    //}
                }
                
                    for eventTag in self.eventTagStructure{
                        let eventTagNod = self.getArLocationTagNode(locationTagStructure: eventTag)
                        //if (self.actualDistance2.isLess(than: 50)){
                        self.eventNodes.append(eventTagNod!)
                        //}
                    }
                    
                    for tresureBox in self.treasureboxStructure{
                        if !self.hasProperty(key: tresureBox.fullname){
                            self.addProperty(key: tresureBox.fullname, value: tresureBox)
                        }
                        
                        let convertedToClLocation =  ARLocation.convertToCllocation(latitude: tresureBox.latitude, longitude: tresureBox.longitude)
                        
                        self.self.bearing = Float(ARLocation.getBearingBetweenTwoPoints1(point1: (self.arLocation?.currentLocation)!, point2: convertedToClLocation))
                        let actualDistance = self.arLocation?.currentLocation.distance(from: convertedToClLocation)
                        let openGlDistance = ARLocationTagScene.findDistance(distance: actualDistance!)
                        
                        let locationTag = ARLocationTagNode(image: tresureBox.buildingType, title: tresureBox.name, description: tresureBox.description, distance : openGlDistance, fullName : tresureBox.fullname)
                        
                        locationTag.create()
                        let elevateDistance = self.findElevateDistance(actualDistance: Float(actualDistance!), openGlDistance: openGlDistance)
                        
                        
                        let x = sin(self.locationPitch.degreesToRadians) * sin(self.bearing.degreesToRadians) * openGlDistance
                        let y = (cos(self.locationPitch.degreesToRadians) * openGlDistance) - elevateDistance + 4.5
                        let z = sin(self.locationPitch.degreesToRadians) * cos(self.bearing.degreesToRadians) * openGlDistance
                        
                        //let position : SCNVector3 = SCNVector3(x:-x,y:-y,z:z)
                        
                        let position : SCNVector3 = SCNVector3(x:0,y:-3,z:7.5)
                        //let eulerAngle : SCNVector3 = SCNVector3(x:0, y: -self.bearing, z:0)
                        
                        locationTag.setPosition(positions: position)
                        //if (actualDistance?.isLess(than: 50))!{
                        self.nodes.append(locationTag)
                        self.eventNodes.append(locationTag)
                        //}
                        
                    }
                    
                
                    if(self.isTagClicked){
                    return;
                    }
                    
                    //for nd in self.treasureBoxNodes{
//                        self.nodes.append(nd)
//                        self.eventNodes.append(nd)
                    //}
                    if !self.isEventMode{
                        ViewController.setNodes(nodes: self.nodes)
                        
                    }else{
                        ViewController.setNodes(nodes: self.eventNodes)
                    }
        }
                
            }
//            else{
//                print("Did not go to if block")
//                print("Arlocation : \(arLocation)")
//                print("Arlocation Distance : \(actualDistance1)")
//        }
        
    }
    
    
    private var isRunning = true
    
    //private var locationSensor : GPSLocationSensor?
    //var locationService = LocationService.getLocationServiceInstance() --> working
    //private var locationService : LocationService = LocationService()
    
    var locationService = LocationService().getLocationServiceInstance()
    var custView = UIView()
    var nodes : [ARNode] = []
    var eventNodes : [ARNode] = []
    //var treasureBoxNodes : [ARNode] = []
    var eventButton = UIButton(type: .custom)
    var mapUiButton = UIButton()
    

    
    
    //private var motionSensor : MotionSensors?
    private var _properties = [String : LocationTagStructure]()
    
    private var prevCompassUpdateTime : Double = 0.0
    
    private var isTagClicked : Bool = false
    
    private var isEventMode : Bool = false
    
    private var prevLocationUpdateTime : Double = 0.0
    
    private var arLocation : ARLocation?
    

    
    private static var LOCATION_UPDATE_TIME : Double = 1000
    
    private static var MIN_UPDATE_DISTANCE : Float = 2
    
    private static var NEAR_DISTANCE_LIMIT : Float = 20
    
    private static var FAR_DISTANCE_LIMIT : Float = 120
    
    private static var MAX_ACTUAL_DISTANCE : Float = 200
    
    private static var MAX_OPENGL_DISTANCE : Float = 10
    
    private static var MIN_OPENGL_DISTANCE : Float = 5
    
    private static var ELEVATE_GUARD_DISTANCE : Float = 1.0
    
    //private var locationService : LocationService = LocationService()
    
    var locationPitch : Float = 270.0
    
    var bearing : Float = 0.0
    
    private var locationTagStructures : [LocationTagStructure] = [LocationTagStructure]()
    
    private var eventTagStructure : [LocationTagStructure] = [LocationTagStructure]()
    
    private var treasureboxStructure : [LocationTagStructure] = [LocationTagStructure]()
    
    public override func create() -> Void{
        arLocation = nil
        isRunning = true
        do
        {
            let currentLocation = try LocationService.getLocation()
                GPSLocationAvailable(location: currentLocation)
        }catch{
            print("Error from create \(error)")
        }
        
        ViewController._onClickListenerDelegate = self
        locationService.setLocationSensorListenerDelegate(locationListenerDelegate: self)
        
        prevCompassUpdateTime = 0
        prevLocationUpdateTime = 0
    }
    
    public override func start() -> Void{
        if(isRunning){
            create()
        }
    }
    
    func getNearByEvent() -> [LocationTagStructure] {
        var eventTagStructuresList : [LocationTagStructure] = [LocationTagStructure]()
//        let eventTagStructure = LocationTagStructure(id: 1, latitude: 32.98638, longitude: -96.75770, altitude: 10, name: "This is event", fullname: "Nischal", description: "Hit Event Button", buildingType: "Changed_Event_Tag")
//        eventTagStructure1.append(eventTagStructure) --> UTD Testing
    //--------------------- ------- Zoo Tags ---------------
//        let eventTagStructure = LocationTagStructure(id: 1, latitude: 32.7404869, longitude: -96.8160537, altitude: 0, name: "Flamingo", fullname: "Nischal", description: "01:30 PM", buildingType: "Changed_Event_Tag")
//        let eventTagStructure1 = LocationTagStructure(id: 1, latitude: 32.7404869, longitude: -96.8160537, altitude: 0, name: "Wings of Wonder", fullname: "Nischal", description: "01:30 PM", buildingType: "Changed_Event_Tag")
//
//        let eventTagStructure2 = LocationTagStructure(id: 1, latitude: 32.74054, longitude: -96.81565, altitude: 0, name: "Wild Show", fullname: "Nischal", description: "11:00 AM", buildingType: "Changed_Event_Tag")
//
//        let eventTagStructure3 = LocationTagStructure(id: 1, latitude: 32.7412469, longitude: -96.8177408, altitude: 0, name: "Tiger", fullname: "Nischal", description: "03:00 PM", buildingType: "Changed_Event_Tag")
//
//        eventTagStructuresList.append(eventTagStructure)
//        eventTagStructuresList.append(eventTagStructure1)
//        eventTagStructuresList.append(eventTagStructure2)
//        eventTagStructuresList.append(eventTagStructure3)
        //-----------------------------------Work Event Tag --------------
        
//        let eventTagStructure3 = LocationTagStructure(id: 1, latitude: 32.92218, longitude: -96.77009, altitude: 0, name: "Tiger", fullname: "Nischal", description: "03:00 PM", buildingType: "Changed_Event_Tag")
        
        //--------------------------------------UTD events----------------------
//        let locationStructure = LocationTagStructure(id: 1001, latitude: 32.98625, longitude: -96.75780, altitude: 200, name: "Flamingo", fullname: "Flamingo Pond event", description: "Flamingo Pond", buildingType: "Changed_Event_Tag")
//
//        let locationStructure1 = LocationTagStructure(id: 1003, latitude: 32.98682, longitude:  -96.75706, altitude: 200, name: "Wings of Wonder", fullname: "Winds of Wonder event", description: "Winds of wonder", buildingType: "Changed_Event_Tag")
//
//        let locationStructure2 = LocationTagStructure(id: 1004, latitude: 32.98584, longitude: -96.75729, altitude: 200, name: "Wondering of the Wild Show", fullname: "Cat Green Pavilion event", description: "Dining Area. Serves best bear!!", buildingType: "Changed_Event_Tag")
//
//        let locationStructure3 = LocationTagStructure(id: 1022, latitude: 32.98622, longitude: -96.75672, altitude: 200, name: "Tiger", fullname: "Sumatran Tiger event", description: "Tiger", buildingType: "Changed_Event_Tag")
        
       // ------------------------------home events-------------------
//
//        let locationStructure = LocationTagStructure(id: 1001, latitude: 33.16010, longitude: -96.71421, altitude: 200, name: "Flamingo", fullname: "Flamingo Pond event", description: "Flamingo Pond", buildingType: "Changed_Event_Tag")
//
//        let locationStructure1 = LocationTagStructure(id: 1003, latitude: 33.15964, longitude:  -96.71422, altitude: 200, name: "Wings of Wonder", fullname: "Winds of Wonder event", description: "Winds of wonder", buildingType: "Changed_Event_Tag")
//
//        let locationStructure2 = LocationTagStructure(id: 1004, latitude: 33.15988, longitude: -96.71461, altitude: 200, name: "Wondering of the Wild Show", fullname: "Cat Green Pavilion event", description: "Dining Area. Serves best bear!!", buildingType: "Changed_Event_Tag")
//
//        let locationStructure3 = LocationTagStructure(id: 1022, latitude: 33.15990, longitude: -96.71373, altitude: 200, name: "Tiger", fullname: "Sumatran Tiger event", description: "Tiger", buildingType: "Changed_Event_Tag")
        //------------------------------State Fair Events---------------------
        let locationStructure = LocationTagStructure(id: 1001, latitude: 32.77722, longitude: -96.75923, altitude: 200, name: "Carnival Lido Deck Stage Show", fullname: "Flamingo Pond event", description: "Ongoing", buildingType: "Changed_Event_Tag")
        
        let locationStructure1 = LocationTagStructure(id: 1003, latitude: 32.78010, longitude: -96.75859, altitude: 200, name: "Dr Peper Stage Show", fullname: "Winds of Wonder event", description: "Ongoing", buildingType: "Changed_Event_Tag")
        
        let locationStructure2 = LocationTagStructure(id: 1004, latitude: 32.78229, longitude: -96.76164, altitude: 200, name: "Chevrolet Main Stage Show", fullname: "Cat Green Pavilion event", description: "Next 1:00 PM", buildingType: "Changed_Event_Tag")
        
//        let locationStructure3 = LocationTagStructure(id: 1022, latitude: 32.98622, longitude: -96.75672, altitude: 200, name: "Tiger", fullname: "Sumatran Tiger event", description: "Tiger", buildingType: "Changed_Event_Tag")
        
        eventTagStructuresList.append(locationStructure)
        eventTagStructuresList.append(locationStructure1)
        eventTagStructuresList.append(locationStructure2)
        //eventTagStructuresList.append(locationStructure3)
        //eventTagStructuresList.append(locationStructure4)
        
        return eventTagStructuresList
    
    }
    
    func getNearByTresureBox() -> [LocationTagStructure] {
        var tresureBoxStructures : [LocationTagStructure] = [LocationTagStructure]()
        //-----------------UTD--------------------//
        let tresureBoxStructure = LocationTagStructure(id: 1, latitude: 32.98637, longitude: -96.75842, altitude: 10, name: "", fullname: "Nischal", description: "Tresure box", buildingType: "Treasure_Box")
        //----------work------------
//        let tresureBoxStructure = LocationTagStructure(id: 1, latitude: 32.92204, longitude: -96.77026, altitude: 10, name: "", fullname: "Nischal", description: "Tresure box", buildingType: "Treasure_Box")
        //---------------------Home--------------
//        let tresureBoxStructure = LocationTagStructure(id: 1, latitude: 33.15958, longitude: -96.71419, altitude: 10, name: "", fullname: "Tresure box", description: "Tresure box", buildingType: "Treasure_Box")
        tresureBoxStructures.append(tresureBoxStructure)
        return tresureBoxStructures
        
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
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

    
    public func getNearbyLocations() -> [LocationTagStructure]{
        var locationStructuresList : [LocationTagStructure] = [LocationTagStructure]()
        
        //---------------------------    Zoo Location   ---------------------------------------//
//        let locationStructure = LocationTagStructure(id: 1001, latitude: 32.7404869, longitude: -96.8160537, altitude: 200, name: "Flamingo Pond", fullname: "Flamingo Pond", description: "Flamingo Pond", buildingType: "General School Building")
        
//        let locationStructure1 = LocationTagStructure(id: 1003, latitude: 32.7398659, longitude: -96.8164969, altitude: 200, name: "Winds of Wonder", fullname: "Winds of Wonder", description: "Winds of wonder", buildingType: "General School Building")
//
//        let locationStructure2 = LocationTagStructure(id: 1004, latitude: 32.7402387, longitude: -96.8168718, altitude: 200, name: "Cat Green Pavilion", fullname: "Cat Green Pavalion", description: "Dining Area. Serves best bear!!", buildingType: "General School Building")
//
//        let locationStructure3 = LocationTagStructure(id: 1022, latitude: 32.7412469, longitude: -96.8177408, altitude: 200, name: "Sumatran Tiger", fullname: "Tiger", description: "Tiger", buildingType: "General School Building")
//
//         let locationStructure4 = LocationTagStructure(id: 1025, latitude: 32.7406784, longitude: -96.8167192, altitude: 200, name: "Prime Meridian Cafe", fullname: "Prime meridian", description: "Tiger", buildingType: "General School Building")
//
//        locationStructuresList.append(locationStructure)
//        locationStructuresList.append(locationStructure1)
//        locationStructuresList.append(locationStructure2)
//        locationStructuresList.append(locationStructure3)
//        locationStructuresList.append(locationStructure4)
        
         //----------------------------------Home Location zoo loc------------------------//

//        let locationStructure = LocationTagStructure(id: 1001, latitude: 33.16010, longitude: -96.71421, altitude: 200, name: "Flamingo Pond", fullname: "Flamingo Pond", description: "Flamingo Pond", buildingType: "General School Building")
//
//        let locationStructure1 = LocationTagStructure(id: 1003, latitude: 33.15964, longitude:   -96.71422, altitude: 200, name: "Winds of Wonder", fullname: "Winds of Wonder", description: "Winds of wonder", buildingType: "General School Building")
//
//        let locationStructure2 = LocationTagStructure(id: 1004, latitude: 33.15988, longitude: -96.71461, altitude: 200, name: "Cat Green Pavilion", fullname: "Cat Green Pavilion", description: "Dining Area. Serves best bear!!", buildingType: "General School Building")
//
//        let locationStructure3 = LocationTagStructure(id: 1022, latitude: 33.15990, longitude:  -96.71373, altitude: 200, name: "Sumatran Tiger", fullname: "Sumatran Tiger", description: "Tiger", buildingType: "General School Building")
//
//        let locationStructure4 = LocationTagStructure(id: 1025, latitude: 33.15973, longitude:  -96.71390, altitude: 200, name: "Prime Meridian Cafe", fullname: "Prime Meridian Cafe", description: "Tiger", buildingType: "General School Building")
//
//        locationStructuresList.append(locationStructure)
//        locationStructuresList.append(locationStructure1)
//        locationStructuresList.append(locationStructure2)
//        locationStructuresList.append(locationStructure3)
//        locationStructuresList.append(locationStructure4)
        //--------------------------------------------UTD zoo loc----------------------------------------------------//
//
//        let locationStructure = LocationTagStructure(id: 1001, latitude: 32.98584, longitude:  -96.75725, altitude: 200, name: "Flamingo Pond", fullname: "Flamingo Pond", description: "Flamingo Pond", buildingType: "General School Building")
//
//        let locationStructure1 = LocationTagStructure(id: 1003, latitude: 32.98629, longitude:   -96.75666, altitude: 200, name: "Winds of Wonder", fullname: "Winds of Wonder", description: "Winds of wonder", buildingType: "General School Building")
//
//        let locationStructure2 = LocationTagStructure(id: 1004, latitude: 32.98677, longitude: -96.75711, altitude: 200, name: "Cat Green Pavilion", fullname: "Cat Green Pavilion", description: "Dining Area. Serves best bear!!", buildingType: "General School Building")
//
//        let locationStructure3 = LocationTagStructure(id: 1022, latitude: 32.98559, longitude:  -96.75768, altitude: 200, name: "Sumatran Tiger", fullname: "Sumatran Tiger", description: "Tiger", buildingType: "General School Building")
//
//        let locationStructure4 = LocationTagStructure(id: 1025, latitude: 32.98640, longitude: -96.75939, altitude: 200, name: "Prime Meridian Cafe", fullname: "Prime Meridian Cafe", description: "Tiger", buildingType: "General School Building")
//
//        locationStructuresList.append(locationStructure)
//        locationStructuresList.append(locationStructure1)
//        locationStructuresList.append(locationStructure2)
//        locationStructuresList.append(locationStructure3)
//        locationStructuresList.append(locationStructure4)
        
        //-------------------------Work Location zoo loc------------
//            let locationStructure = LocationTagStructure(id: 1001, latitude: 32.92192, longitude:  -96.77027, altitude: 200, name: "Flamingo Pond", fullname: "Flamingo Pond", description: "Flamingo Pond", buildingType: "General School Building")
//
//            let locationStructure1 = LocationTagStructure(id: 1003, latitude: 32.92234, longitude:   -96.76973, altitude: 200, name: "Winds of Wonder", fullname: "Winds of Wonder", description: "Winds of wonder", buildingType: "General School Building")
//
//            let locationStructure2 = LocationTagStructure(id: 1004, latitude: 32.92276, longitude: -96.77027, altitude: 200, name: "Cat Green Pavilion", fullname: "Cat Green Pavilion", description: "Dining Area. Serves best bear!!", buildingType: "General School Building")
//
//            let locationStructure3 = LocationTagStructure(id: 1022, latitude: 32.92248, longitude:  -96.77090, altitude: 200, name: "Sumatran Tiger", fullname: "Sumatran Tiger", description: "Tiger", buildingType: "General School Building")
//
//            let locationStructure4 = LocationTagStructure(id: 1025, latitude: 32.92202, longitude: -96.77105, altitude: 200, name: "Prime Meridian Cafe", fullname: "Prime Meridian Cafe", description: "Tiger", buildingType: "General School Building")
//
//            locationStructuresList.append(locationStructure)
//            locationStructuresList.append(locationStructure1)
//            locationStructuresList.append(locationStructure2)
//            locationStructuresList.append(locationStructure3)
//            locationStructuresList.append(locationStructure4)
        
        //-------------------------State Fare UTD---------
        
        
//        let locationStructure = LocationTagStructure(id: 1001, latitude: 32.77658, longitude: -96.75935, altitude: 200, name: "Texas Star", fullname: "Flamingo Pond", description: "Flamingo Pond", buildingType: "General School Building")
//
//        let locationStructure1 = LocationTagStructure(id: 1003, latitude: 32.77902, longitude: -96.75911, altitude: 200, name: "Stadium", fullname: "Winds of Wonder", description: "Winds of wonder", buildingType: "General School Building")
//
//        let locationStructure2 = LocationTagStructure(id: 1004, latitude: 32.77823, longitude: -96.75839, altitude: 200, name: "Admin Building", fullname: "Cat Green Pavilion", description: "Dining Area. Serves best bear!!", buildingType: "General School Building")
//
//        let locationStructure3 = LocationTagStructure(id: 1022, latitude: 32.98559, longitude:  -96.75768, altitude: 200, name: "Sumatran Tiger", fullname: "Sumatran Tiger", description: "Tiger", buildingType: "General School Building")
//
//        let locationStructure4 = LocationTagStructure(id: 1025, latitude: 32.98640, longitude: -96.75939, altitude: 200, name: "Prime Meridian Cafe", fullname: "Prime Meridian Cafe", description: "Tiger", buildingType: "General School Building")
//
//        locationStructuresList.append(locationStructure)
//        locationStructuresList.append(locationStructure1)
//        locationStructuresList.append(locationStructure2)
//        locationStructuresList.append(locationStructure3)
//        locationStructuresList.append(locationStructure4)

        
        //------------------State fare home ---------
        
        let locationStructure = LocationTagStructure(id: 1001, latitude: 32.77658, longitude: -96.75935, altitude: 200, name: "Texas Star", fullname: "Flamingo Pond", description: "Flamingo Pond", buildingType: "General School Building")
        
        let locationStructure1 = LocationTagStructure(id: 1003, latitude: 32.77902, longitude:   -96.75911, altitude: 200, name: "Stadium", fullname: "Winds of Wonder", description: "Winds of wonder", buildingType: "General School Building")
        
        let locationStructure2 = LocationTagStructure(id: 1004, latitude: 32.77823, longitude: -96.75839, altitude: 200, name: "Admin Building", fullname: "Cat Green Pavilion", description: "Dining Area. Serves best bear!!", buildingType: "General School Building")
        
//        let locationStructure3 = LocationTagStructure(id: 1022, latitude: 33.15990, longitude:  -96.71373, altitude: 200, name: "Sumatran Tiger", fullname: "Sumatran Tiger", description: "Tiger", buildingType: "General School Building")
//
//        let locationStructure4 = LocationTagStructure(id: 1025, latitude: 33.15973, longitude:  -96.71390, altitude: 200, name: "Prime Meridian Cafe", fullname: "Prime Meridian Cafe", description: "Tiger", buildingType: "General School Building")
        
        locationStructuresList.append(locationStructure)
        locationStructuresList.append(locationStructure1)
        locationStructuresList.append(locationStructure2)
//        locationStructuresList.append(locationStructure3)
//        locationStructuresList.append(locationStructure4)

        
        return locationStructuresList
        
//        return LocationTagService.getNearbyLocations(latitude: (arLocation?.currentLocation.coordinate.latitude)!, longitude: (arLocation?.currentLocation.coordinate.longitude)!)
    }
    
    private func findElevateDistance(actualDistance : Float, openGlDistance : Float) -> Float{
     //print("Horizontal : \(ViewController.getHorizonatlFieldOfView())")
        //var openGlDist = openGlDistance
        if actualDistance < ARLocationTagScene.NEAR_DISTANCE_LIMIT{
            return 0
        }
        
        //if actualDistance >= ARLocationTagScene.FAR_DISTANCE_LIMIT {
        //    openGlDist = ARLocationTagScene.MAX_OPENGL_DISTANCE
        //}
      
        let hFov = ViewController.getHorizonatlFieldOfView()
        let vFov = hFov / (ViewController.getScnkitAspectRatio())
        
        let elevateAngle = (openGlDistance - ARLocationTagScene.MIN_OPENGL_DISTANCE) / (ARLocationTagScene.MAX_OPENGL_DISTANCE - ARLocationTagScene.MIN_OPENGL_DISTANCE + ARLocationTagScene.ELEVATE_GUARD_DISTANCE) * (vFov / 2)


        let elevateDistance = ARLocationTagScene.MIN_OPENGL_DISTANCE * sin(elevateAngle.degreesToRadians)
        return elevateDistance
        
    }
}


extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}







