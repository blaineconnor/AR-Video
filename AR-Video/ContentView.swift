//
//  ContentView.swift
//  AR-Video
//
//  Created by Fatih Emre Sarman on 11.07.2024.
//

import SwiftUI
import RealityKit
import AVFoundation

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        guard let url = Bundle.main.url(forResource: "production ID_3818213", withExtension: "mp4") else {
            fatalError("Video file was not found!")
        }
        
        let player = AVPlayer(url: url)
        
        let material = VideoMaterial(avPlayer: player)
        
        material.controller.audioInputMode = .spatial
        
        let modelEntity = ModelEntity(mesh: MeshResource.generatePlane(width: 0.5, depth: 0.5), materials: [material])
        
        modelEntity.transform.rotation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0])
        
        player.play()
        
        anchor.addChild(modelEntity)
        
        arView.scene.addAnchor(anchor)
        
        do {
                   try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                   try AVAudioSession.sharedInstance().setActive(true)
               } catch {
                   print("Failed to set audio session category.")
               }
        
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap))
                arView.addGestureRecognizer(tapGesture)
                context.coordinator.player = player

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
}

//#Preview {
//    ContentView()
//}
