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

    func getGenres() -> [Genre] {
        return repository.getGenres()
    }
}
