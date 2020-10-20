
//  VisionView.swift
//  Vision-Obcject-Tracking
//
//  Created by Jan Konieczny on 20/10/2020.

import UIKit
import SwiftUI
import Vision

struct VisionView: View {
    @State var imageToProcess: UIImage
    @State var image: Image?
    @State private var detectedFaces: [VNFaceObservation] = []
    
    let faceDetector = FaceDetector()
    
    var body: some View {
       
            VStack{
                Text("I have detected \(detectedFaces.count) on selected photo")
                    .font(.headline)
                    .padding()
                Image(uiImage: imageToProcess)
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        ZStack{
                            ForEach(self.detectedFaces, id: \.self) { face in
                                GeometryReader { geometry in
                                    Rectangle()
                                        .rotation(.radians(-Double(truncating: face.roll ?? 0)), anchor: .center)
                                        .path(in: drawRectangle(on: face, size: geometry.size))
                                        .stroke(Color.yellow, lineWidth: 2.5)
                                }
                            }
                        }
                    )
                
            }.onAppear {
                do {
                    try  detectedFaces = faceDetector.faceDetect(UIImage: imageToProcess)
                } catch {
                    
                }
            }

    }
    
    func drawRectangle(on face: VNFaceObservation, size: CGSize) -> CGRect {
        let rect = CGRect(
            x: face.boundingBox.minX * size.width,
            y: ((1 - face.boundingBox.maxY) * size.height),
            width:  face.boundingBox.width * size.width,
            height:  face.boundingBox.height * size.height)
        return rect
    }
}

