//
//  XMCharactersListViewModel.swift
//  CharacterViewer
//
//  Created by Krishna teja Kalluri on 2/5/19.
//  Copyright © 2019 xfinity. All rights reserved.
//

import UIKit

class XMCharactersListViewModel: NSObject {

    var characters: [XMCharacter]?
    var matchingCharacters: [XMCharacter]?
    
    var reloadData: (() -> Void)? //Block to reload collection view
    var reloadDetailData: (() -> Void)? //Block to reload Detail View controller
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        
        guard let characters = self.matchingCharacters else {
            return 0
        }
        return characters.count
    }
    
    override init() {
        super.init()
        fetchCharacters()
    }
    
    func characterAtIndex(index: Int) -> XMCharacter {
        guard let characters = self.matchingCharacters else {
            assert(false, "Charcaters list is empty")
        }
        return characters[index]
    }
    
    /** Make API call and get list of characters
    */
    func fetchCharacters() {
        XMCharctersApiManager.fetchCharacters(completion: { [unowned self] (isSuccess, allCharacters) in
            if isSuccess, let characters = allCharacters {
                self.characters = characters
                self.matchingCharacters = characters
                self.reloadData?()
                self.reloadDetailData?()
            }
            
        })
    }
    
    /** Search characters from previously fetched list
    */
    func searchCharcters(matching string: String?) {
        guard let matchingString = string else {
            self.matchingCharacters = self.characters
            self.reloadData?()
            return
        }
        let matchCharacters = self.characters?.filter({(aCharacter) in
            guard let characterTitle = aCharacter.title, let desc = aCharacter.description else {
                return false
            }
            
            if characterTitle.lowercased().contains(matchingString.lowercased()) || desc.lowercased().contains(matchingString.lowercased()) {
                return true
            }else {
                return false
            }
        })
        self.matchingCharacters = matchCharacters
        self.reloadData?()
    }
    
}
