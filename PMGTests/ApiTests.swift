//
//  ApiTests.swift
//  PMGTests
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import XCTest
import Moya
import SwiftyJSON
@testable import PMG

class ApiTests: XCTestCase {

    var provider: MoyaProvider<MovieApiService>!
    
    override func setUpWithError() throws {
        //super.setUp()
        
        provider = MoyaProvider<MovieApiService>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
    }

    func customEndpointClosure(_ target: MovieApiService) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.testSampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetMovies() throws {
        provider.request(.getMovies, completion: { (result) in
            switch result {
            case .success(let response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    var movies = [Movie]()
                    if let movieArray = json["results"].array {
                        for movieJson in movieArray {
                            if let movie = Movie(json: movieJson) {
                                movies.append(movie)
                            }
                        }
                    }
                    XCTAssertEqual(movies.count, 6)
                } catch {
                    XCTFail()
                }
            case .failure:
                XCTFail()
            }
        })
    }
    
    func testGetCharacter() throws {
        provider.request(.getMovieCharacter(url: "http://swapi.dev/api/people/1/"), completion: { (result) in
            switch result {
            case .success(let response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let character = MovieCharacter(json: json)
                    XCTAssertEqual(character.name, "Luke Skywalker")
                } catch {
                    XCTFail()
                }
            case .failure:
                XCTFail()
         
            }
        })
    }

}

extension MovieApiService {
    var testSampleData: Data {
        let bundle = Bundle(for: ApiTests.self)
        
        switch self {
        case .getMovies:
            guard let url = bundle.url(forResource: "Movies", withExtension: "json") else {
                return Data()
            }
            return try! Data(contentsOf: url)
        case .getMovieCharacter:
            guard let url = bundle.url(forResource: "Character", withExtension: "json") else {
                return Data()
            }
            return try! Data(contentsOf: url)
        }
    }
}

