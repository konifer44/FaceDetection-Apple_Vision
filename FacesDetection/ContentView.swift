//
//  ContentView.swift
//  FacesDetection
//
//  Created by Jan Konieczny on 20/10/2020.
//
import Vision
import UIKit
import SwiftUI
//
//enum ActiveSheet: Identifiable {
//    case imagePickerSheet, detectedFacesSheet
//    var id: Int {
//        hashValue
//    }
//}

struct ContentView: View {
    @EnvironmentObject var faceDetector: FaceDetector
    @State var inputImage: UIImage?
    @State var image: Image?
    @State var imagePickerSheetIsPresented = false
    
    
    var body: some View {
        ZStack {
            Background()
                .blur(radius: (image == nil) ? 0 : 5)
            VStack{
                Spacer()
                if image == nil {
                    WelcomeView(imagePickerSheetIsPresented: $imagePickerSheetIsPresented)
                } else {
                    DetectedFacesImage(image: $image)
                        .frame(width: 400, alignment: .center)
                }
                Spacer()
                Button(
                    action: {
                        imagePickerSheetIsPresented = true
                    },
                    label: {
                        Text("CHOOSE IMAGE")
                            .font(.title3)
                            .fontWeight(.bold)
                    })
                    .frame(width: 320, height: 55, alignment: .center)
                    .background(Color(red: 0, green: 200/255, blue: 120/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(5)
            }
        }
        
        .sheet(isPresented: $imagePickerSheetIsPresented, onDismiss: loadImage){
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        faceDetector.faceDetect(UIImage: inputImage)
    }}


func drawRectangle(on face: VNFaceObservation, size: CGSize) -> CGRect {
    let rect = CGRect(
        x: face.boundingBox.minX * size.width,
        y: ((1 - face.boundingBox.maxY) * size.height),
        width:  face.boundingBox.width * size.width,
        height:  face.boundingBox.height * size.height)
    return rect
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct WelcomeView: View {
    @Binding var imagePickerSheetIsPresented: Bool
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image(systemName: "square.dashed")
                    .font(Font.system(size: 280, weight: .light))
                Image(systemName: "face.smiling")
                    .font(.system(size: 130))
                
                
            }
            .foregroundColor(.white)
            
            HStack(spacing: 0) {
                Text("FACE-")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("DETECT")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0, green: 200/255, blue: 120/255))
            }
            Spacer()
            
        }
    }
}

struct DetectedFacesImage: View {
    @EnvironmentObject var faceDetector: FaceDetector
    @Binding var image: Image?
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    image = nil
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(Color.gray.opacity(0.8))
                        .padding()
                })
            }
            image?
                .resizable()
                .scaledToFit()
                .overlay(
                    ZStack{
                        ForEach(faceDetector.detectedFaces, id: \.self) { face in
                            GeometryReader { geometry in
                                Rectangle()
                                    .rotation(.radians(-Double(truncating: face.roll ?? 0)), anchor: .center)
                                    .path(in: drawRectangle(on: face, size: geometry.size))
                                    .stroke(Color.yellow, lineWidth: 2.5)
                            }
                        }
                    }
            )
            Text("Detected faces: \(faceDetector.detectedFaces.count)")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

struct Background: View {
    var body: some View {
        Image("backgroundImage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
        Color(.black).opacity(0.9).edgesIgnoringSafeArea(.all)
    }
}
