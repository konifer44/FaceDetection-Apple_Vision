# Face Detection with Apple Vision Framework
>A basic app thats using Apple Vision Framework.

```swift
func faceDetectWithThrows(UIImage: UIImage) throws -> [VNFaceObservation]{
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
```  
 <h3>Screenshots</h3>
 <p align="center">
   <img src="screen1.PNG" alt="drawing" width="200"/>
   <img src="screen2.PNG" alt="drawing" width="200"/>
 </p>
  
