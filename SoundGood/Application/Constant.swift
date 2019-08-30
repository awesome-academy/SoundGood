//
//  Constant.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/22/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

enum Constant {
    static let apiKey = "7c8ae3eed403b61716254856c4155475"
    static let genres = [Genre(key: "alternativerock", title: "Alternative Rock"),
                         Genre(key: "ambient", title: "Ambient"),
                         Genre(key: "classical", title: "Classical"),
                         Genre(key: "country", title: "Country"),
                         Genre(key: "danceedm", title: "Dance EDM"),
                         Genre(key: "dancehall", title: "Dancehall"),
                         Genre(key: "deephouse", title: "Deep House"),
                         Genre(key: "disco", title: "Disco"),
                         Genre(key: "drumbass", title: "Drum & Bass"),
                         Genre(key: "dupstep", title: "Dupstep"),
                         Genre(key: "electronic", title: "Electronic"),
                         Genre(key: "house", title: "House"),
                         Genre(key: "folksingersongwriter", title: "Folk & Singer-songwriter"),
                         Genre(key: "hiphoprap", title: "Hiphop & Rap"),
                         Genre(key: "indie", title: "Indie"),
                         Genre(key: "jazzblues", title: "Jazz & Blues"),
                         Genre(key: "latin", title: "Latin")]
    static let searchDelay = 1.0
    static let numberOfHistoryTrackDisplay = 3
}
