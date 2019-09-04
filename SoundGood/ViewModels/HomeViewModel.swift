//
//  HomeViewModel.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/4/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

class HomeViewModel {
    private let repository: TrackRepository

    init(repository: TrackRepository) {
        self.repository = repository
    }

    func getHomeTracks(kind: String, completion: @escaping ([Track]?, BaseError?) -> Void) {
        var tracks = [Track]()
        repository.getTracksByKind(kind: kind, limit: Constant.requestLimit) { response in
            switch response {
            case .success(let homeTrackResponse):
                guard let collection = homeTrackResponse?.trackCollection else { return }
                for item in collection {
                    tracks.append(item.track)
                }
                completion(tracks, nil)
            case .failure(let error):
                guard let error = error else { return }
                completion(nil, error)
            }
        }
    }
}
