//
//  AddImageView.swift
//  ImageListChallenge
//
//  Created by Santiago Pelaez Rua on 25/03/21.
//

import SwiftUI
import CoreLocation

struct AddImageView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var imageName = ""
    
    let locationFetcher = LocationFetcher()
    
    let onSave: (UIImage, String, CLLocationCoordinate2D) -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            
            Spacer()
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 300, height: 300, alignment: .center)
                    .background(
                        Rectangle()
                            .fill(Color.white)
                            .shadow(color: Color.gray, radius: 4, x: -4.0, y: 4.0)
                    )
            } else {
                Button("Add Image +") {
                    showingImagePicker = true
                }
                .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .shadow(color: Color.gray, radius: 4, x: -4.0, y: 4.0)
                )
            }
            
            
            TextField("Name", text: $imageName)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()

            
            Button("Save") {
                onSave(selectedImage!,
                       imageName,
                       locationFetcher.lastKnownLocation ?? CLLocationCoordinate2D())
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.blue)
            .font(.title)
            .foregroundColor(.white)
            .cornerRadius(8.0)
            .disabled(selectedImage == nil && !imageName.isEmpty)
            
            Spacer()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        .navigationTitle("Add Image")
        .onAppear(perform: locationFetcher.start)
    }
}

struct AddImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddImageView(onSave: {_,_,_ in })
        }
    }
}
