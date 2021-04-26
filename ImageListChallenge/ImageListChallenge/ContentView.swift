//
//  ContentView.swift
//  ImageListChallenge
//
//  Created by Santiago Pelaez Rua on 24/03/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var images = [NamedImage]()
    
    var body: some View {
        
        return NavigationView {
            Group {
                if images.isEmpty {
                    Text("Add your first image.")
                } else {
                    ScrollView {
                        LazyVStack(alignment: .center, spacing: 15.0) {
                            ForEach(images) { item in
                                NavigationLink(
                                    destination: ImageDetail(namedImage: item)
                                ) {
                                    VStack(alignment: .center, spacing: 15) {
                                        Image(uiImage: item.image)
                                            .resizable()
                                            .scaledToFit()
                                            .background(
                                                Rectangle()
                                                    .fill(Color.white)
                                                    .shadow(color: Color.gray, radius: 4, x: -4.0, y: 4.0)
                                            )
                                        Text(item.name)
                                            .foregroundColor(Color.black)
                                            .italic()
                                            .padding(.bottom)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Images")
            .navigationBarItems(trailing: NavigationLink(
                                    destination: AddImageView(onSave: saveImage),
                                    label: {
                                        Image(systemName: "plus")
                                    }))
            .onAppear(perform: loadImages)
        }
    }
    
    private func saveImage(_ image: UIImage, name: String, location: CLLocationCoordinate2D) {
        let namedImage = NamedImage(name: name, image: image, location: location)
        images.append(namedImage)
        images.sort()
        saveImagesToDisk()
    }
    
    private func saveImagesToDisk() {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(images)
            try data.write(to: Self.imagesURL, options: .atomicWrite)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    private func loadImages() {
        do {
            let data = try Data(contentsOf: Self.imagesURL)
            let namedImages = try JSONDecoder().decode([NamedImage].self,
                                                       from: data)
            images = namedImages
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    private static var imagesURL: URL = {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask)[0]
       
        return documentsDirectory.appendingPathComponent("namedImages")
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
