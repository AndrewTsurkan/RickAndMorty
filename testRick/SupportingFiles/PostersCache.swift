//
//  CachFiles.swift
//  testRick
//
//  Created by Андрей Цуркан on 19.11.2022.
//

import UIKit

class PostersCache {
    
    static let shared = PostersCache()

    private let imageCache = NSCache<NSString, UIImage>()

    func save(url: String, image: UIImage) {
        imageCache.setObject(image, forKey: url as NSString)
    }

    func getImage(url: String) -> UIImage? {
        imageCache.object(forKey: url as NSString)
    }

}
