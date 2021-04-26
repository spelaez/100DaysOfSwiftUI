//
//  ImageDetail.swift
//  ImageListChallenge
//
//  Created by Santiago Pelaez Rua on 25/03/21.
//

import SwiftUI
import MapKit

struct ImageDetail: View {
    let namedImage: NamedImage
    
    var body: some View {
            VStack(alignment: .center) {
                Image(uiImage: namedImage.image)
                    .resizable()
                    .scaledToFill()
                
                Spacer()
                
                Text(namedImage.name)
                    .font(.title)
                    .italic()
                    .padding()
                
                Spacer()
                
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: namedImage.location,
                                                                   span: MKCoordinateSpan(latitudeDelta: 0.5,
                                                                                          longitudeDelta: 0.5))),
                    annotationItems: [namedImage]) { item in
                    MapPin(coordinate: item.location)
                }
                .frame(maxHeight: 100)
                
                Spacer(minLength: 20)
        }
        .navigationBarTitle(Text(""),
                            displayMode: .inline)
    }
}

struct ImageDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ImageDetail(namedImage: NamedImage.example[0])
        }
    }
}
