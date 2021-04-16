//
//  FacesDetectionApp.swift
//  FacesDetection
//
//  Created by Jan Konieczny on 20/10/2020.
//

import SwiftUI

@main
struct FacesDetectionApp: App {
    @StateObject var faceDetector = FaceDetector()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(faceDetector)
        }
    }
}
