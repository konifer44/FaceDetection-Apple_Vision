//
//  VisionTrackerController.swift
//  Vision-Obcject-Tracking
//
//  Created by Jan Konieczny on 18/10/2020.
//

import Foundation
import UIKit
import SwiftUI
import Vision

class FaceDetector {
    enum FaceDetectorError: Error{
        case loadingImageError
        case noFacesDetected
        
    }
    
    func faceDetect(UIImage: UIImage) throws -> [VNFaceObservation]{
        guard let CGImageToProcess = UIImage.cgImage else {throw FaceDetectorError.loadingImageError}
        
        let detectedFacesRequest  = VNDetectFaceRectanglesRequest()
        let requestHandler = VNImageRequestHandler(cgImage: CGImageToProcess)
        do{
            try requestHandler.perform([detectedFacesRequest])
        } catch let error as NSError {
            print(error)
        }
        
        guard let detectedFaces = detectedFacesRequest.results as? [VNFaceObservation] else {
            throw FaceDetectorError.noFacesDetected
        }
        
        
        return detectedFaces
    }
}
