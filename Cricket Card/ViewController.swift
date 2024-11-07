//
//  ViewController.swift
//  Cricket Card
//
//  Created by Darsh viroja  on 01/10/24.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.automaticallyUpdatesLighting = true
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
       if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Cricket Card", bundle: Bundle.main)
        {
           
           configuration.trackingImages = imageToTrack
           configuration.maximumNumberOfTrackedImages = 2
        }
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: any SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? 
    {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor
        {
            let plane =  SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            let planeNode = SCNNode(geometry: plane)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            planeNode.eulerAngles.x = -.pi/2

            
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "virat"
            {
                
                if let cricketScene = SCNScene(named: "art.scnassets/virat_kohli.scn")
                {
                    if let cricketNode = cricketScene.rootNode.childNodes.first
                    {
                        
                        cricketNode.eulerAngles.x = .pi/2
                        
                        cricketNode.position = SCNVector3(x: planeNode.position.x, y: planeNode.position.y + cricketNode.boundingSphere.radius/2, z: planeNode.position.z)
                        
                        
                        planeNode.addChildNode(cricketNode)
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "rohit"
            {
                if let cricketScene = SCNScene(named: "art.scnassets/rohit_sharma.scn")
                {
                    if let cricketNode = cricketScene.rootNode.childNodes.first
                    {
                        
                        cricketNode.eulerAngles.x = .pi/2
                        
                        cricketNode.position = SCNVector3(x: planeNode.position.x, y: planeNode.position.y + cricketNode.boundingSphere.radius/2, z: planeNode.position.z)
                        
                        
                        planeNode.addChildNode(cricketNode)
                    }
                }
                
            }
            
        }
        
        return node
    }
}
