//
//  ContentView.swift
//  FacesDetection
//
//  Created by Jan Konieczny on 20/10/2020.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case imagePickerSheet, detectedFacesSheet
    var id: Int {
        hashValue
    }
}

struct ContentView: View {
    @State var activeSheet: ActiveSheet?
    @State var inputImage: UIImage?
    @State private var boundingBox: CGRect = CGRect()
    
    var body: some View {
        NavigationView{
            
            VStack {
                Spacer()
                Button(action: {
                    activeSheet = .imagePickerSheet
                }) {
                    HStack {
                        Image(systemName: "photo.on.rectangle")
                            .font(.title)
                        Text("Choose Image")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .frame(width: 300, height: 70, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(40)
                    .padding(.horizontal, 20)
                }.padding(.bottom, 80)
                
                
                Button(action: {
                    activeSheet = .detectedFacesSheet
                }) {
                    HStack {
                        Image(systemName: "person.3")
                            .font(.title)
                        Text("Detected Faces")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .frame(width: 300, height: 70, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(40)
                    .padding(.horizontal, 20)
                }.disabled(inputImage == nil)
                Spacer()
                
            }.sheet(item: $activeSheet) { item in
                switch item {
                case .imagePickerSheet:
                    ImagePicker(image: self.$inputImage).onDisappear(perform: loadImage)
                case .detectedFacesSheet:
                    VisionView(imageToProcess: inputImage!)
                }
            }
            .navigationBarTitle("Faces Detector")
        }
    }
    func loadImage() {
        activeSheet = .detectedFacesSheet
    }
}
