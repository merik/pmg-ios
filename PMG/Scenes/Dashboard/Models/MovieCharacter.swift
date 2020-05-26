//
//  MovieCharacter.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import SwiftyJSON

final class MovieCharacter {
    var name = ""
    var birthYear = ""
    var eyeColor = ""
    var gender = ""
    var height = ""
    var mass = ""
    var skinColor = ""
    
    var url = ""
    
    init(url: String) {
        self.url = url
    }
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.height = json["height"].stringValue
        self.mass = json["mass"].stringValue
        self.birthYear = json["birth_year"].stringValue
        self.eyeColor = json["eye_color"].stringValue
        self.gender = json["gender"].stringValue
        self.skinColor = json["skin_color"].stringValue
        self.url = json["url"].stringValue
    }
    
    var valid: Bool {
        return !name.isEmpty
    }
}
