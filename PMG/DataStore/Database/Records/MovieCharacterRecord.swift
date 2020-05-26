//
//  CharacterRecord.swift
//  PMG
//
//  Created by Erik Mai on 26/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import GRDB

extension MovieCharacter: TableRecord {
    
    static var databaseTableName: String {
        return "character"
    }
    
    enum Column: String, ColumnExpression {
        case url, name, birthYear, eyeColor, gender, height, mass, skinColor
    }
}

extension MovieCharacter: FetchableRecord {
    convenience init(row: Row) {
        self.init(url: "")
        url = row[Column.url]
        name = row[Column.name]
        birthYear = row[Column.birthYear]
        eyeColor = row[Column.eyeColor]
        gender = row[Column.gender]
        height = row[Column.height]
        mass = row[Column.mass]
        skinColor = row[Column.skinColor]
    }
}

extension MovieCharacter: MutablePersistableRecord {
    func encode(to container: inout PersistenceContainer) {
        container[Column.url] = url
        container[Column.name] = name
        container[Column.birthYear] = birthYear
        container[Column.eyeColor] = eyeColor
        container[Column.gender] = gender
        container[Column.height] = height
        container[Column.mass] = mass
        container[Column.skinColor] = skinColor
    
    }
}

