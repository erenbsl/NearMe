//
//  ImageDownloader.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/22.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import UIKit

/// ImageDownloader is a simple shared object to download and cache images.
/// (Can be modified to have an operation queue)
class ImageDownloader {
    
    private var cache: NSCache<NSString, UIImage>
    
    static var shared = ImageDownloader()
    
    typealias ImageDownloaderCompletion = ((UIImage?, Error?) -> Void)?
    
    init() {
        cache = NSCache<NSString, UIImage>()
    }
    
    /// Downloads the image at given url and stores it in the cache. If it's already cached, calls the completion immediately with the found image.
    /// - parameter key: url string to download/cache the image with. nothing happens if it's an invalid url.
    /// - parameter completion: The closure that's called when the operation is finished, either via finding the image on cache or after a succesful or failed download.
    func image(for key: String, completion: ImageDownloaderCompletion) {
        if let image = cache.object(forKey: key as NSString) {
            DispatchQueue.main.async {
                completion?(image, nil)
                return
            }
        }
        
        downloadImage(with: key, completion: completion)
    }
    
    private func downloadImage(with urlString: String, completion: ImageDownloaderCompletion) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession.shared
        session.downloadTask(with: url) { [weak self] (location, response, error) in
            guard let weakSelf = self else {
                return
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    completion?(nil, error)
                    return
                }
            }
            
            if let location = location, let data = try? Data(contentsOf: location), let image = UIImage(data: data) {
                // got the image, cache it and return
                weakSelf.cache.setObject(image, forKey: urlString as NSString)
                
                DispatchQueue.main.async {
                    completion?(image, nil)
                    return
                }
            }
            
            }.resume()
    }
}
