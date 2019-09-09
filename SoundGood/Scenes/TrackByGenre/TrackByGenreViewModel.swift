//
//  TrackByGenreViewModel.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/6/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

class TrackByGenreViewModel {
    private let repository: TrackRepository
    let trackObservable = Observable<BaseResult<HomeResponse>>()

    init(repository: TrackRepository) {
        self.repository = repository
    }

    func getTrackByGenre(with key: String) {
        repository.getTracksByGenre(with: key, limit: Constant.requestLimit) { [weak self] response in
            self?.trackObservable.value = response
        }
    }
}
