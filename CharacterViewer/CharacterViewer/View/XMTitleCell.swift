//
//  XMCharacterCell.swift
//  CharacterViewer
//
//  Created by Krishna teja Kalluri on 2/5/19.
//  Copyright © 2019 xfinity. All rights reserved.
//

import UIKit

class XMTitleCell: UICollectionViewCell {
    @IBOutlet weak var characterTitleLabel: UILabel!
    
    func configure(withTitle title:String?) {
        characterTitleLabel.text = title ?? "Character Title Not available"
    }
}
