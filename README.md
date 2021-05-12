# Face Detection with Apple Vision Framework
>A basic app thats using Apple Vision Framework.

```swift
func faceDetect(UIImage: UIImage){
        guard let CGImageToProcess = UIImage.cgImage else { return }
        
        let detectedFacesRequest  = VNDetectFaceRectanglesRequest()
        let requestHandler = VNImageRequestHandler(cgImage: CGImageToProcess)
        do{
            try requestHandler.perform([detectedFacesRequest])
        } catch let error as NSError {
            print(error)
        }
        
        guard let detectedFaces = detectedFacesRequest.results as? [VNFaceObservation] else { return }
        self.detectedFaces = detectedFaces
    }
```  
 <h3>Screenshots</h3>
 <p align="center">
   <img src="screen1.PNG" alt="drawing" width="200"/>
   <img src="screen2.PNG" alt="drawing" width="200"/>
 </p>
  
