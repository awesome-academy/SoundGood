//
//  Constant.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/22/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

enum Constant {
    static let genres = [Genre(key: "soundcloud:genres:alternativerock", title: "Alternative Rock"),
                         Genre(key: "soundcloud:genres:ambient", title: "Ambient"),
                         Genre(key: "soundcloud:genres:classical", title: "Classical"),
                         Genre(key: "soundcloud:genres:country", title: "Country"),
                         Genre(key: "soundcloud:genres:danceedm", title: "Dance EDM"),
                         Genre(key: "soundcloud:genres:dancehall", title: "Dancehall"),
                         Genre(key: "soundcloud:genres:deephouse", title: "Deep House"),
                         Genre(key: "soundcloud:genres:disco", title: "Disco"),
                         Genre(key: "soundcloud:genres:drumbass", title: "Drum & Bass"),
                         Genre(key: "soundcloud:genres:dupstep", title: "Dupstep"),
                         Genre(key: "soundcloud:genres:electronic", title: "Electronic"),
                         Genre(key: "soundcloud:genres:house", title: "House"),
                         Genre(key: "soundcloud:genres:folksingersongwriter", title: "Folk & Singer-songwriter"),
                         Genre(key: "soundcloud:genres:hiphoprap", title: "Hiphop & Rap"),
                         Genre(key: "soundcloud:genres:indie", title: "Indie"),
                         Genre(key: "soundcloud:genres:jazzblues", title: "Jazz & Blues"),
                         Genre(key: "soundcloud:genres:latin", title: "Latin")]
    static let searchDelay = 1.0
    static let numberOfHistoryTrackDisplay = 3
    static let requestLimit = 20
}

enum TableViewConstant {
    static let heightForTableViewCell = 100
}
