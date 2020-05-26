//
//  JsonParsingTests.swift
//  PMGTests
//
//  Created by Erik Mai on 26/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import PMG

class JsonParsingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitMovieFromJson() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "Movie", withExtension: "json") else {
            XCTFail("Missing file: Movie.json")
            return
        }

        let jsonData = try Data(contentsOf: url)
        let json = try JSON(data: jsonData)
        let movie = Movie(json: json)
        
        XCTAssertEqual(movie?.episodeId, 4)
        XCTAssertEqual(movie?.director, "George Lucas")
        XCTAssertEqual(movie?.producer, "Gary Kurtz, Rick McCallum")
        XCTAssertEqual(movie?.releaseDate, "1977-05-25")
        XCTAssertEqual(movie?.characters.count, 18)
        
    }
    
    func testInitCharacterFromJson() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "Character", withExtension: "json") else {
            XCTFail("Missing file: Character.json")
            return
        }

        let jsonData = try Data(contentsOf: url)
        let json = try JSON(data: jsonData)
        let character = MovieCharacter(json: json)
        
        XCTAssertEqual(character.name, "Luke Skywalker")
        XCTAssertEqual(character.height, "172")
        XCTAssertEqual(character.mass, "77")
        XCTAssertEqual(character.birthYear, "19BBY")
        XCTAssertEqual(character.gender, "male")
        XCTAssertEqual(character.url, "http://swapi.dev/api/people/1/")
        
    }
   
}
