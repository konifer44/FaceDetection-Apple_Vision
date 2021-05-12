# Face Detection with Apple Vision Framework
>A basic app thats using Apple Vision Framework.
##Detect faces
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

##Draw rectangle on face
```swift
func drawRectangle(on face: VNFaceObservation, size: CGSize) -> CGRect {
    let rect = CGRect(
        x: face.boundingBox.minX * size.width,
        y: ((1 - face.boundingBox.maxY) * size.height),
        width:  face.boundingBox.width * size.width,
        height:  face.boundingBox.height * size.height)
    return rect
}
```
 <h3>Screenshots</h3>
 <p align="center">
   <img src="screen1.PNG" alt="drawing" width="200"/>
   <img src="screen2.PNG" alt="drawing" width="200"/>
 </p>
  
