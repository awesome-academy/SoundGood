//
//  TrackDataSource.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/3/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

protocol TrackDataSource {
    func getTracksByKind(kind: String, limit: Int, completion: @escaping (BaseResult<HomeTrackResponse>) -> Void)
}

class TrackRemoteDataSource: TrackDataSource {

    private var apiService: ApiService

    init(apiService: ApiService) {
        self.apiService = apiService
    }

    func getTracksByKind(kind: String, limit: Int, completion: @escaping (BaseResult<HomeTrackResponse>) -> Void) {
        let input = HomeRequest(url: ApiConstant.ApiChartUrl, kind: kind, limit: limit)
        apiService.request(input: input) { (object: HomeTrackResponse?, error) in
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
