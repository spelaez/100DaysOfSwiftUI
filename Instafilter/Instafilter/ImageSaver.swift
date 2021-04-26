//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Santiago Pelaez Rua on 14/03/21.
//

import UIKit

class ImageSaver: NSObject {
    var sucessHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            sucessHandler?()
        }
    }
}
