//
//  PhotoNode.swift
//  beauty
//
//  Created by Ubicolor on 08/12/2021.
//

import SceneKit
import SpriteKit

class PhotoNode: SCNNode {
    
    var photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        super.init()
        print(photo.ratio)
        let plane = SCNPlane(width: 0.6,
                             height: 0.6 / photo.ratio )
        
        plane.cornerRadius = 0.03
        
        eulerAngles.x = -.pi/2
        geometry = plane
        
        guard let photoString = photo.src[Photo.Size.large.rawValue],
              let url = URL(string: photoString ),
              let image = try? Data(contentsOf: url)
        else { return }
        
        let material = SCNMaterial()
        material.lightingModel = .constant
        material.diffuse.contents =  image

        plane.firstMaterial = material
        let text = SCNText(string: photo.photographer, extrusionDepth: 0.01)
        text.flatness = 0.001

        let authorNode = SCNNode(geometry: text)
        authorNode.scale = SCNVector3(0.005, 0.005, 0.005 )
        addChildNode(authorNode)
        
        authorNode.position.x = -0.3
        authorNode.position.y = Float(-0.2 / photo.ratio)
        authorNode.position.z = 0.1
        
                                 
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
