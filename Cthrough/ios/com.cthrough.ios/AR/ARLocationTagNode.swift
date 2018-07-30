//
//  LocationTagNode.swift
//  Cthrough
//
//  Created by Nischal Panwala on 3/5/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class ARLocationTagNode: ARNode {
    
    private static var _height : CGFloat = 0.7
    
    private static var _eventTagHeight : CGFloat = 0.7
    
    private static var _treasureBoxHeight : CGFloat = 2
    
    private var _imageName : String = String()
    
    private var _staticImageName : String = ".png"
    
    private var _description : String = String()
    
    private var _fullName : String = String()
    
    private var _title : String = String()
    
    private var _distance : Float = Float()
    
    private var _imageScenceNode : SCNNode = SCNNode()
    
    private var _titleScenceNode : SCNNode = SCNNode()
    
    private var _descriptionScenceNode : SCNNode = SCNNode()
    
    init(image : String, title : String, description : String, distance : Float, fullName : String) {
        self._imageName = image
        self._description = description
        self._title = title
        self._distance = distance
        self._fullName = fullName
    }
    
    func create() {
        _imageScenceNode = ARLocationTagNode.make2dNode(image:UIImage(named: _imageName + _staticImageName)!, text: _title, imageName: _imageName + _staticImageName, distance: self._distance, fullName: self._fullName, description : self._description)
    }
    
    func getImage() -> SCNNode{
        return _imageScenceNode
    }
    
    func setPosition(positions: SCNVector3) {
        _imageScenceNode.position = positions
        let bear = .pi - atan2(-positions.x, positions.z)
        _imageScenceNode.eulerAngles = SCNVector3(x:0, y: bear, z:0)
    }
    
    func setEulerAngle(eulerAngle: SCNVector3) {
        _imageScenceNode.eulerAngles = eulerAngle
    }
    
    func getType() -> String {
        return "LocationTagNode"
    }

    public static func make2dNode(image: UIImage, text : String, imageName : String, distance : Float, fullName : String, description : String) -> SCNNode {
        var plane = SCNPlane()
        if imageName == "Changed_Event_Tag.png"{
            plane = SCNPlane(width: findWidth(w: image.size.width, h: image.size.height, nodeTypeHeight: ARLocationTagNode._eventTagHeight), height: ARLocationTagNode._eventTagHeight)
        }else if imageName == "Treasure_Box.png"{
            plane = SCNPlane(width: findWidth(w: image.size.width, h: image.size.height, nodeTypeHeight: ARLocationTagNode._treasureBoxHeight), height: ARLocationTagNode._treasureBoxHeight)
        }else{
        plane = SCNPlane(width: findWidth(w: image.size.width, h: image.size.height, nodeTypeHeight: ARLocationTagNode._height), height: ARLocationTagNode._height)
        }
        plane.firstMaterial!.diffuse.contents = createNodeWithSpriteKit(imageName: imageName, text: text, distance: distance, description: description)
        
        let node = SCNNode(geometry: plane)
        node.name = fullName
        return node
    }
    
    public static func createNodeWithSpriteKit(imageName : String, text : String, distance : Float, description : String) -> SKScene {
        var finalText = String()
        let skScn = SKScene(size: CGSize(width: 1276.0 / 2.0, height: 712.0 / 2.0))
        skScn.scaleMode = .aspectFit
        skScn.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        
        let skNode = SKSpriteNode(imageNamed: imageName)
        skNode.position = CGPoint(x: skScn.size.width / 2.0, y: skScn.size.height / 2.0)

        skNode.yScale = -1
        skNode.size = skScn.size
        let titleLabel = SKLabelNode(fontNamed:"Helvetica-Bold")
        if text.count >= 12{
            let indx = text.index(text.startIndex,offsetBy: 12)
            finalText = String(text[..<indx])
            let character = "..."
            let arrChar = Array(character)
            for char in arrChar{
                finalText.insert(char, at: indx)
            }
            titleLabel.text = finalText
        }else{
            titleLabel.text = text
        }
        
        titleLabel.fontSize = 55
        if imageName == "General School Building.png"{
        if text == "Tiger" || text == "Flamingo" || text == "Stadium" || text == "Texas Star"{
            titleLabel.position = CGPoint(x: skScn.size.width / 8, y: skScn.size.height / 8)
        }else{
            titleLabel.horizontalAlignmentMode = .left
            titleLabel.position.x = -100
            titleLabel.position.y = skScn.size.height / 8
        }
        }
        if imageName == "Changed_Event_Tag.png"{
            if text == "Tiger" || text == "Flamingo"{
                titleLabel.position = CGPoint(x: skScn.size.width / 8, y: skScn.size.height / 8)
            }else{
                titleLabel.horizontalAlignmentMode = .left
                titleLabel.position.x = -80
                titleLabel.position.y = skScn.size.height / 8
            }
        }
        let distanceLabel = SKLabelNode(fontNamed: "Helvetica-Bold")
        if imageName == "Changed_Event_Tag.png"{
            distanceLabel.text = description
        }
        if imageName == "General School Building.png"{
            let constructDistanceString = "\(String(format: "%.0f", distance * 3.28)) ft"
            distanceLabel.text = constructDistanceString
        }
        distanceLabel.fontSize = 50
        distanceLabel.position = CGPoint(x: skScn.size.width / 8, y: -60)
        

        skNode.addChild(distanceLabel)
        skNode.addChild(titleLabel)
        skScn.addChild(skNode)
        
        
        return skScn
    }
    
    static func findWidth(w : CGFloat, h : CGFloat, nodeTypeHeight : CGFloat) -> CGFloat{
        return (w / h) * nodeTypeHeight
        
    }
}
