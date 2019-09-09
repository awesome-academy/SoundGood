//
//  TrackDataSource.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/3/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

protocol TrackDataSource {
    func getTracksByKind(kind: String, limit: Int, completion: @escaping (BaseResult<HomeResponse>) -> Void)

    func searchTrack(with text: String, limit: Int, completion: @escaping (BaseResult<SearchResponse>) -> Void)

    func getTracksByGenre(with key: String, limit: Int, completion: @escaping (BaseResult<HomeResponse>) -> Void)
}

class TrackRemoteDataSource: TrackDataSource {

    private var apiService: ApiService

    init(apiService: ApiService) {
        self.apiService = apiService
    }

    func getTracksByKind(kind: String, limit: Int, completion: @escaping (BaseResult<HomeResponse>) -> Void) {
        let input = HomeRequest(url: ApiConstant.ApiChartUrl, kind: kind, limit: limit)
        apiService.request(input: input) { (object: HomeResponse?, error) in
            guard let collection = object else {
                guard let error = error else {
                    completion(.failure(error: nil))
                    return
                }
                completion(.failure(error: error as? BaseError))
                return
            }
            completion(.success(collection))
        }
    }

    func searchTrack(with text: String, limit: Int, completion: @escaping (BaseResult<SearchResponse>) -> Void) {
        let input = SearchRequest(url: ApiConstant.ApiSearchTrackUrl, keyword: text, limit: limit)
        apiService.request(input: input) { (object: SearchResponse?, error) in
            guard let collection = object else {
                guard let error = error else {
                    completion(.failure(error: nil))
                    return
                }
                completion(.failure(error: error as? BaseError))
                return
            }
            completion(.success(collection))
        }
    }

    func getTracksByGenre(with key: String, limit: Int, completion: @escaping (BaseResult<HomeResponse>) -> Void) {
        let input = TrackByGenreRequest(url: ApiConstant.ApiChartUrl, genre: key, limit: limit)
        apiService.request(input: input) { (object: HomeResponse?, error) in
            guard let collection = object else {
                guard let error = error else {
                    completion(.failure(error: nil))
                    return
                }
                completion(.failure(error: error as? BaseError))
                return
            }
            completion(.success(collection))
        }
    }
}
