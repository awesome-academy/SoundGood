//
//  GenreRepository.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/27/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

protocol GenreRepository {
    func getGenreTitles(genres: [String: String]) -> [String]
}

class GenreDataRepository: GenreRepository {
    private let localDataSource: GenreDataSource

    init(localDataSource: GenreDataSource) {
        self.localDataSource = localDataSource
    }

    func getGenreTitles(genres: [String: String]) -> [String] {
        return localDataSource.getGenreTitles(genres: genres)
    }
}
