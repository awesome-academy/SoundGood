//
//  HomeViewModel.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/4/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

class HomeViewModel {
    private let repository: TrackRepository
    let trackObservable: Observable<BaseResult<HomeTrackResponse>> = Observable()

    init(repository: TrackRepository) {
        self.repository = repository
    }

    func getHomeTracks(kind: String) {
        repository.getTracksByKind(kind: kind, limit: Constant.requestLimit) { [weak self] response in
            self?.trackObservable.value = response
        }
    }
}
