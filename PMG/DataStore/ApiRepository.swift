//
//  ApiRepository.swift
//  PMG
//
//  Created by Erik Mai on 25/5/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import SwiftyJSON

class ApiError: Swift.Error {
    
    private var statusCode = -1
    private var error = ""
    private var errorMessage = ""
    
    init?(json: JSON) {
        self.statusCode = json["status_code"].intValue
        error = json["error"].stringValue
        errorMessage = json["message"].stringValue
        
    }
    
    class var genericError: ApiError {
        let errorJson: [String: Any] = ["status_code": 500, "error": "Generic", "message": "Error"]
        return ApiError(json: JSON(errorJson))!
    }
}

class ApiRepository: BaseRepository {
    
    private let disposeBag = DisposeBag()
    private static let apiDebug = true
    
    private static let networkLoggerPlugin = NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(formatter: .init(), output: { (_, array) in
        for log in array {
            print(log)
        }
    }, logOptions: [.errorResponseBody, .formatRequestAscURL]))

    #if DEBUG
    let movieService = MoyaProvider<MovieApiService>(callbackQueue: DispatchQueue.global(qos: .utility), plugins: apiDebug ? [networkLoggerPlugin] : [])
    #else
    let movieService = MoyaProvider<MovieApiService>(callbackQueue: DispatchQueue.global(qos: .utility))
    #endif
    
    func isHttpSuccess(code: Int) -> Bool {
        return (code >= 200 && code < 300)
    }
    
    func getMovieList() -> Observable<[Movie]> {
        return Observable.create { observer in
            self.movieService.request(.getMovies, completion: { (result) in
                switch result {
                case .success(let response):
                    do {
                        let data = response.data
                        let json = try JSON(data: data) // convert network data to json
                        if self.isHttpSuccess(code: response.statusCode) {
                            var movies = [Movie]()
                            if let movieArray = json["results"].array {
                                for movieJson in movieArray {
                                    if let movie = Movie(json: movieJson) {
                                        movies.append(movie)
                                    }
                                }
                            }
                            observer.onNext(movies)
                            observer.onCompleted()
                            
                        } else {
                            let error = ApiError(json: json) ?? ApiError.genericError
                            observer.onError(error)
                        }
                    } catch {
                        observer.onError(ApiError.genericError)
                    }
                case .failure(let error):
                    observer.onError(ApiError.genericError)
                }
            })
            return Disposables.create {
               
            }
        }
    }
    
    func getCharacter(from url: String) -> Observable<MovieCharacter> {
        return Observable.create { observer in
            self.movieService.request(.getMovieCharacter(url: url), completion: { (result) in
                switch result {
                case .success(let response):
                    do {
                        let data = response.data
                        let json = try JSON(data: data) // convert network data to json
                        if self.isHttpSuccess(code: response.statusCode) {
                            let character = MovieCharacter(json: json)
                            observer.onNext(character)
                            observer.onCompleted()
                            
                        } else {
                            let error = ApiError(json: json) ?? ApiError.genericError
                            observer.onError(error)
                        }
                    } catch {
                        observer.onError(ApiError.genericError)
                    }
                case .failure(let error):
                    print(error)
                    observer.onError(ApiError.genericError)
                }
            })
            return Disposables.create {
                
            }
        }
    }
}
