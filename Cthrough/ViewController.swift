//
//  ViewController.swift
//  ArCamera
//
//  Created by Nischal Panwala on 12/6/17.
//  Copyright © 2017 Nischal Panwala. All rights reserved.
//

import UIKit
import AVFoundation
import SceneKit
import GoogleMaps
import SpriteKit
//import CoreMotion

var captureSession: AVCaptureSession?
var videoPreviewLayer: AVCaptureVideoPreviewLayer?
var scene : SCNScene = SCNScene()
private var _horizontalFieldOfView : Float = Float()
let cameraNode = SCNNode()
var imageNode = SCNNode()
private let arLocatiotag = ARLocationTagScene(name: "AR_TAG_SCENE")
var _bearing : Float = 0.0
var _azimuth : Float = 0.0
var locationService = LocationService().getLocationServiceInstance()
let motionSensor = MotionSensors()

var scnHeight : CGFloat = 0
var scnWidth : CGFloat = 0

class ViewController: UIViewController, MotionSensorListenerDelegate{

    //change name to arviewcontorller
    
    @IBOutlet weak var camView: UIView!
    //@IBOutlet weak var overLay: OverLayView!
    @IBOutlet weak var scnKitView: SCNView!
    
    static weak var _onClickListenerDelegate : OnClickListenerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mapButton = UIButton(type: .custom)
        mapButton.setImage(UIImage(named: "2D_Button")!, for: .normal)
        mapButton.frame = CGRect(x: UIScreen.main.bounds.width - 89, y: UIScreen.main.bounds.height - 116, width: 62, height: 62)
        mapButton.contentMode = .center
        mapButton.imageView?.contentMode = .scaleAspectFit
        mapButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        view.addSubview(mapButton)
        
        
        arLocatiotag.addEventButton(view: view, mapButton: mapButton)
        
        let captureDevice = AVCaptureDevice.default(for: .video)
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            _horizontalFieldOfView = (captureDevice?.activeFormat.videoFieldOfView)!
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
        }catch{
            print(error)
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        camView.layer.addSublayer(videoPreviewLayer!)
        captureSession?.startRunning()
        
       
        
        

        do{
            try motionSensor.start()
        } catch{
            print(error)
        }
        
        motionSensor.setMotionSensorListenerDelegate(motionSensorListenerDelegate: self)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        
        let scnView = scnKitView as SCNView
        scene = SCNScene()
        scnView.scene = scene
        
        scnHeight = scnView.frame.height
        scnWidth = scnView.frame.width
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = false
        scnView.isPlaying = true
        // show statistics such as fps and timing information
        //scnView.showsStatistics = true
        
        
        // configure the view
        scnView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
        //For Static Location (Debug Purpose)
//        cameraNode.eulerAngles = SCNVector3(
//            x: -Float(1.7634 - .pi/2),
//            y: Float(-6.24),
//            z: Float(0))
//        cameraNode.camera = SCNCamera()
//        scene.rootNode.addChildNode(cameraNode)
//
//        let arNode = ARLocationTagNode.make2dNode(image: UIImage(named: "General School Building.png")!, text: "some", imageName: "General School Building")
//        arNode.position = SCNVector3(0,0,-5)
//        scene.rootNode.addChildNode(arNode)
        
         arLocatiotag.start()
        
    }
    
    public static func getScnkitAspectRatio() -> Float{
        if(scnWidth != 0 && scnHeight != 0){
            return Float(scnWidth/scnHeight)
        }else{
            return -1
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Main_Controller_Id")
        self.present(newViewController, animated: true, completion: nil)
        locationService.removeLocationSensorListenerDelegate()
        motionSensor.removeMotionSensorListenerDelegate()
        locationService.stopUpdatingLocation()
        motionSensor.stop()
        scene.rootNode.enumerateChildNodes { (node, stop) -> Void in
            node.removeFromParentNode()
        }
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = scnKitView as SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            //let material = result.node.geometry!.firstMaterial!
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            scene.rootNode.enumerateChildNodes { (node, stop) -> Void in
                node.removeFromParentNode()
            }
            let res = scnView.projectPoint(result.node.presentation.worldPosition)
            if ViewController._onClickListenerDelegate != nil{
                ViewController._onClickListenerDelegate.OnClick(view: view!, text: result.node.name!, sceneVec : res)
            }
            
           
            SCNTransaction.commit()
        }
    }
    

    
    public func CreateNodeWithSK() -> SKScene{
        let skScn = SKScene(size: CGSize(width: 1276.0 / 2.0, height: 712.0 / 2.0))
        skScn.scaleMode = .aspectFit
        skScn.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        return skScn

    }
    
    public static func getHorizonatlFieldOfView() -> Float {
        return _horizontalFieldOfView
    }
    
    public static func setNodes(nodes : [ARNode]){
        scene.rootNode.enumerateChildNodes { (node, stop) -> Void in
            node.removeFromParentNode()
        }
        
        for node in nodes{
            
            scene.rootNode.addChildNode(node.getImage())
        }
        
        cameraNode.camera = SCNCamera()
        
        scene.rootNode.addChildNode(cameraNode)
    }
    
    func motionSensorAvailable(motionSensor: ARMotionSensor) {
        cameraNode.eulerAngles = SCNVector3(
            x: -Float(motionSensor.tiltAngle - .pi/2),
            y: Float(-motionSensor.compass),
            z: Float(0))
    }
}

