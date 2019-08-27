//
//  GenreDataSource.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/27/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

protocol GenreDataSource {
    func getGenreTitles(genres: [String: String]) -> [String]
}

struct GenreLocalDataSource: GenreDataSource {

    func getGenreTitles(genres: [String: String]) -> [String] {
        var titles = [String]()
        genres.forEach { pair in
            titles.append(pair.value)
        }
        return titles
    }
}
