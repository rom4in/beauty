//
//  ARView.swift
//  beauty
//
//  Created by Ubicolor on 08/12/2021.
//

import ARKit
import SwiftUI

struct ARView : UIViewRepresentable {

    @State var photo: Photo
    private let coach = ARCoachingOverlayView()
    private let arView = ARSCNView()
    @State private var isOntheWall = false
    var photoNode : PhotoNode { PhotoNode(photo: photo)}


  func makeUIView(context: Context) -> ARSCNView {
      
    let config = ARWorldTrackingConfiguration()
    config.planeDetection = .vertical
    config.environmentTexturing = .automatic
    arView.session.run(config, options: [])
    arView.delegate = context.coordinator
    arView.autoenablesDefaultLighting = true
    
      arView.addSubview(coach)
      coach.translatesAutoresizingMaskIntoConstraints = false
      let topConstraint = NSLayoutConstraint(item: coach, attribute: .top, relatedBy: .equal, toItem: arView, attribute: .top, multiplier: 1, constant: 0)
      let bottomConstraint = NSLayoutConstraint(item: coach, attribute: .bottom, relatedBy: .equal, toItem: arView, attribute: .bottom, multiplier: 1, constant: 0)
      let leftConstraint = NSLayoutConstraint(item: coach, attribute: .left, relatedBy: .equal, toItem: arView, attribute: .left, multiplier: 1, constant: 0)
      let rightConstraint = NSLayoutConstraint(item: coach, attribute: .right, relatedBy: .equal, toItem: arView, attribute: .right, multiplier: 1, constant: 0)

      NSLayoutConstraint.activate([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
      
    return arView
  }
       

    
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
    
  class Coordinator: NSObject, ARSCNViewDelegate, ARCoachingOverlayViewDelegate {

    let parent : ARView

    init(_ parent: ARView) {
      self.parent = parent
        super.init()
        setupCoachingOverlay()
    }


    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
      if !parent.isOntheWall, anchor is ARPlaneAnchor {
          self.parent.isOntheWall = true
          DispatchQueue.main.async {
              
              node.addChildNode(self.parent.photoNode)
              
          }
      }
    }
      private func setupCoachingOverlay() {
          parent.coach.session = parent.arView.session
          parent.coach.delegate = self
          parent.coach.activatesAutomatically = true
          parent.coach.goal = .verticalPlane
          
          
      }
  }
    
    

  func updateUIView(_ uiView: ARSCNView, context: Context) {}
}

