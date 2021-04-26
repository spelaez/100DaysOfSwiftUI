//
//  EditView.swift
//  BucketList
//
//  Created by Santiago Pelaez Rua on 17/03/21.
//

import SwiftUI
import MapKit
import Combine

// Required for combine trymap
//enum HTTPError: LocalizedError {
//    case statusCode
//}

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    //Required for combine
    //@State private var cancellable: AnyCancellable?
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $placemark.wrappedTitle)
                    TextField("Description", text: $placemark.wrappedSubtitle)
                }
                
                Section(header: Text("Nearby...")) {
                    switch loadingState {
                    case .loaded:
                        List(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                                + Text(": ") +
                                Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading...")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationBarTitle("Edit Place")
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
            .onAppear(perform: fetchNearbyPlaces)
        }
    }
    
    func fetchNearbyPlaces() {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let items = try decoder.decode(Result.self, from: data)
                    pages = Array(items.query.pages.values).sorted()
                    loadingState = .loaded
                    return
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            self.loadingState = .failed
        }.resume()
        
        // This would be the combine counterpart for the code above
        //        cancellable = URLSession.shared.dataTaskPublisher(for: url)
        //            .tryMap { output in
        //                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
        //                    loadingState = .failed
        //                    throw HTTPError.statusCode
        //                }
        //                return output.data
        //            }
        //            .decode(type: Result.self, decoder: JSONDecoder())
        //            .eraseToAnyPublisher()
        //            .sink { completion in
        //                switch completion {
        //                case .finished:
        //                    break
        //                case .failure:
        //                    loadingState = .failed
        //                }
        //            } receiveValue: { places in
        //                pages = Array(places.query.pages.values)
        //                loadingState = .loaded
        //            }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placemark: .example)
    }
}
