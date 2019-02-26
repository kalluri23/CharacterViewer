//
//  XMCharacter.swift
//  CharacterViewer
//
//  Created by Krishna teja Kalluri on 2/4/19.
//  Copyright © 2019 xfinity. All rights reserved.
//

import UIKit

struct XMCharacterList: Codable { //JSON Model containg array of our character objects
    let characters : [XMCharacter]?
    enum CodingKeys: String, CodingKey {
        case characters = "RelatedTopics"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        characters = try values.decodeIfPresent([XMCharacter].self, forKey: .characters)
    }
}

struct XMCharacter: Codable { // JSON Model for a Character Object
    let iconURL : String?
    let title: String?
    let description: String?

    enum InfoKeys: String, CodingKey {
        case iconURL = "Icon"
        case text = "Text"
    }

    enum IconKeys: String, CodingKey {
        case icon = "URL"
    }


    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: InfoKeys.self)
        let icon = try values.nestedContainer(keyedBy: IconKeys.self, forKey:.iconURL)
        iconURL = try icon.decodeIfPresent(String.self, forKey: .icon)
        let text = try values.decodeIfPresent(String.self, forKey: .text)
        title = text?.components(separatedBy: "-").first
        description = text?.components(separatedBy: "-").last
    }
}
