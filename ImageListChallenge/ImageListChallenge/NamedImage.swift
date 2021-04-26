//
//  NamedImage.swift
//  ImageListChallenge
//
//  Created by Santiago Pelaez Rua on 24/03/21.
//

import UIKit
import CoreLocation

struct NamedImage: Codable, Identifiable {
    let id = UUID()
    let name: String
    let image: UIImage
    let location: CLLocationCoordinate2D
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, latitude, longitude
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(location.latitude, forKey: .latitude)
        try container.encodeIfPresent(location.longitude, forKey: .longitude)
        
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            try container.encodeIfPresent(imageData, forKey: .image)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        let imageData = try container.decode(Data.self, forKey: .image)
        image = UIImage(data: imageData) ?? UIImage()
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        
        location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
    }
    
    init(name: String, image: UIImage, location: CLLocationCoordinate2D) {
        self.name = name
        self.image = image
        self.location = location
    }
}

extension NamedImage: Comparable {
    static func == (lhs: NamedImage, rhs: NamedImage) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func < (lhs: NamedImage, rhs: NamedImage) -> Bool {
        return lhs.name < rhs.name
    }
}

extension NamedImage {
    static var example: [NamedImage] = {
        return [
            NamedImage(name: "Example",
                       image: UIImage(systemName: "plus")!,
                       location: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        ]
    }()
}
