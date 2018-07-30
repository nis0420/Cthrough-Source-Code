import UIKit
import SceneKit
import SpriteKit
protocol ARNode {
    func create()
    
    func getImage() -> SCNNode
    
    func setPosition(positions : SCNVector3)
    
    func setEulerAngle(eulerAngle: SCNVector3)
}





