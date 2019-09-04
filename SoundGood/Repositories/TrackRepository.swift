//
//  TrackRepository.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/22/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

protocol TrackRepository {
    func getTracksByKind(kind: String, limit: Int, completion: @escaping (BaseResult<HomeTrackResponse>) -> Void)
}

class TrackDataRepository: TrackRepository {

    private let remoteDataSource: TrackDataSource

    init(remoteDataSource: TrackDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getTracksByKind(kind: String, limit: Int, completion: @escaping (BaseResult<HomeTrackResponse>) -> Void) {
        remoteDataSource.getTracksByKind(kind: kind, limit: limit, completion: completion)
    }
}
