//
//  SecureImageHelper.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/24.
//

import UIKit
import Kingfisher

struct SecureImageHelper {
    
    static let roundCorner = RoundCornerImageProcessor(
            radius: .widthFraction(0.5),
            roundingCorners: [.topLeft, .bottomRight]
        )
    
    static func downloadAndCache(from urlString: String, into imageView: UIImageView) {
        guard let url = URL(string: urlString) else { return }
        
        let resource = KF.ImageResource(downloadURL: url, cacheKey: url.absoluteString + roundCorner.identifier)
        imageView.kf.setImage(
            with: resource,
            options: [
                .processor(roundCorner),
                .cacheOriginalImage
            ]
        )
    }
    
    static func loadCachedImage(from urlString: String, into imageView: UIImageView) {
        guard let url = URL(string: urlString) else { return }
        
        let cacheKey = url.absoluteString
        
        let cache = ImageCache.default
       
        cache.retrieveImage(forKey: cacheKey) { result in
            switch result {
                
            case .success(let value):
                if let cachedImage = value.image {
                    let processed = roundCorner.process(item: .image(cachedImage), options: .init([]))
                        imageView.image = processed
                    print("Retrieved from cache")
                } else {
                    downloadAndCache(from: urlString, into: imageView)
                    print("Downloaded again!!!")
                }
            case .failure(let error):
                downloadAndCache(from: urlString, into: imageView)
                print("Failed to retrieve image from cache: \(error)")
            }
        }
    }
}
