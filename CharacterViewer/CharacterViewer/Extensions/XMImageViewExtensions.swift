//
//  XMImageViewExtension.swift
//  Homesheff
//
//  Created by Krishna teja Kalluri on 2/5/19.
//  Copyright © 2019 xfinity. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    static let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )
    
    //MARK:- Load image from URL
    internal func retrieveImage(for url: String, completion: @escaping (UIImage?) -> Void) {
        let request = Alamofire.request(url)
        request.validate()
        request.responseData { (response) in
            if response.error == nil {
                print(response.result)
                if let data = response.data, let image = UIImage(data: data) {
                    completion(image)
                    UIImageView.cache(image, for: url)
                }else {
                    completion(nil)
                }
            }else {
                print(response.error?.localizedDescription ?? "image loading error")
                completion(nil)
            }
        }
    }
    
    //MARK: = Image Caching
    
    internal class func cache(_ image: Image?, for url: String) {
        guard let image = image else {
            return
        }
        imageCache.add(image, withIdentifier: url)
    }
    
    internal class func cachedImage(for url: String) -> Image? {
        return imageCache.image(withIdentifier: url)
    }
    
    
    //MARK:- Asyn Image View loading
    func loadImageFrom(urlString: String, completion: @escaping (UIImage?) -> ())  {
        
        if let image = UIImageView.cachedImage(for: urlString) {
            completion(image)
            return
        }
        self.retrieveImage(for: urlString) {(image) in
            if let characterImage = image {
                completion(characterImage)
            }else {
                completion(nil)
            }
        }
    }

}
