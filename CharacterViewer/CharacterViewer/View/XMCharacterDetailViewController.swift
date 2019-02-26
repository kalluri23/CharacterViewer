//
//  XMCharacterDetailViewController.swift
//  CharacterViewer
//
//  Created by Krishna teja Kalluri on 2/4/19.
//  Copyright © 2019 xfinity. All rights reserved.
//

import UIKit

class XMCharacterDetailViewController: UIViewController {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    
    var character: XMCharacter? {
        didSet {
          loadViewIfNeeded()
            refreshUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func refreshUI() {
        if let navVc = self.navigationController{
            navVc.navigationBar.topItem?.title = self.character?.title
        }
        self.imageActivityIndicator.startAnimating()
        self.titleLabel.text = self.character?.title
        self.descriptionTextView.text = self.character?.description
        guard let imageUrl = character?.iconURL else {
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

extension XMCharacterDetailViewController: XMCharcaterSelectionDelegate {
    func characterSelected(_ character: XMCharacter) {
        self.character = character
    }
}

