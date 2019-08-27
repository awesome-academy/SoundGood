//
//  GenreViewModel.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/27/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

class GenreViewModel {
    private let repository: GenreRepository

    init(repository: GenreRepository) {
        self.repository = repository
    }

    func getGenreTitles(genres: [String: String]) -> [String] {
        return repository.getGenreTitles(genres: genres)
    }
}
