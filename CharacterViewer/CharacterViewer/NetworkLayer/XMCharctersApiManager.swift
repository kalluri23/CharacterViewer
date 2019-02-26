//
//  XMCharctersApiManager.swift
//  CharacterViewer
//
//  Created by Krishna teja Kalluri on 2/4/19.
//  Copyright © 2019 xfinity. All rights reserved.
//

import Foundation
import Alamofire

class Requestable {
    
    static let basePath = "http://api.duckduckgo.com/"
    
    static var apiPath : String {
        get {
            #if SIMPSONVIEWER
            return basePath + "?q=simpsons+characters&format=json"
            #elseif WIREVIEWER
            return basePath + "?q=the+wire+characters&format=json"
            #else
            return basePath + "?q=simpsons+characters&format=json"
            #endif
        }
    }
    
    static var requestUrl : URL? {
        get {
            return URL(string: apiPath)
        }
    }
}

class XMCharctersApiManager {
    typealias FetchHandler = (Bool, [XMCharacter]?) -> Void
    static let sharedSession = SessionManager()
    class func fetchCharacters(completion: @escaping FetchHandler)  {
        let request = sharedSession.request(Requestable.apiPath)
        request.validate()
            .responseString { response  in
                switch response.result{
                case .success:
                    if let resultValue = response.result.value, let data = response.data
                    {
                        print(resultValue)
                        let jsonDecoder = JSONDecoder()
                        do {
                            let charactersList = try jsonDecoder.decode(XMCharacterList.self, from: data)
                            completion(true, charactersList.characters)
                        }catch let exception { // Parse Error
                            print(exception.localizedDescription)
                            completion(false, nil)
                        }
                    } else {
                        completion(true, nil)
                    }
                case .failure:
                    completion(false, nil)
                }
        }
    }
}
