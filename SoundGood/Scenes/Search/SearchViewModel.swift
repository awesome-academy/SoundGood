//
//  SearchViewModel.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/4/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

class SearchViewModel {
    private let repository: TrackRepository
    let trackObservable: Observable<BaseResult<SearchResponse>> = Observable()

    init(repository: TrackRepository) {
        self.repository = repository
    }

    func searchTracks(with text: String) {
        repository.searchTrack(with: text, limit: Constant.requestLimit) { [weak self] response in
            self?.trackObservable.value = response
        }
    }
}
