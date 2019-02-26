//
//  XMImageCell.swift
//  CharacterViewer
//
//  Created by Krishna teja Kalluri on 2/5/19.
//  Copyright © 2019 xfinity. All rights reserved.
//

import UIKit

class XMImageCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageActivityIndicator.startAnimating()
    }
    
    func configure(withImageUrl url:String?) {
        guard let imageUrl = url else {
            self.imageActivityIndicator.stopAnimating()
            self.characterImageView.image = UIImage(named: "nopreview")
            return
        }
        
        self.characterImageView.loadImageFrom(urlString: imageUrl, completion: {[unowned self] (characterImage) in
            DispatchQueue.main.async {
                self.imageActivityIndicator.stopAnimating()
                if let image = characterImage {
                    self.characterImageView.image = image
                }else {
                    self.characterImageView.image = UIImage(named: "nopreview")
                }
            }
            
        })
    }
}
