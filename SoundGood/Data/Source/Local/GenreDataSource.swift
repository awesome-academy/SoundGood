//
//  GenreDataSource.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/27/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

protocol GenreDataSource {
    func getGenres() -> [Genre]
}

struct GenreLocalDataSource: GenreDataSource {

    func getGenres() -> [Genre] {
        return Constant.genres
    }
}
