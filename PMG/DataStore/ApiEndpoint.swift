//
//  ApiEndpoint.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import Moya

enum MovieApiService {
    case getMovies
    case getMovieCharacter(url: String)
}

extension MovieApiService: TargetType {
    var baseURL: URL {
        let apiUrl = "https://swapi.dev/api"
        
        switch self {
        case .getMovies:
            return URL(string: apiUrl)!
        case .getMovieCharacter(let url):
            return URL(string: url) ?? URL(string: apiUrl)!
        }
        
    }
    
    var path: String {
        switch self {
        case .getMovies:
            return "/films"
        case .getMovieCharacter:
            return ""
        }
    }
    
    var method: Moya.Method {
        return Moya.Method.get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getMovies:
            return .requestParameters(parameters: self.parameters, encoding: URLEncoding.default)
        case .getMovieCharacter:
            return .requestParameters(parameters: self.parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getMovies:
            return [:]
        case .getMovieCharacter:
            return [:]
        }
    }
    
}

