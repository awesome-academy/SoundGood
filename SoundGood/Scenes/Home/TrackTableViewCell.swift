//
//  TrackTableViewCell.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/23/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import Reusable

final class TrackTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var trackImage: UIImageView!
    @IBOutlet private weak var trackTitle: UILabel!
    @IBOutlet private weak var trackArtist: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(imageUrl: String, title: String, artist: String) {
        trackTitle.text = title
        trackArtist.text = artist
    }
}
