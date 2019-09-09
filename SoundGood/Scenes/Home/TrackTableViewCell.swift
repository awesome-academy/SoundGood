//
//  TrackTableViewCell.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/23/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage

final class TrackTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var trackImage: UIImageView!
    @IBOutlet private weak var trackTitle: UILabel!
    @IBOutlet private weak var trackArtist: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(track: Track) {
        trackTitle.text = track.title
        trackArtist.text = track.artist
        trackImage.sd_setImage(with: URL(string: track.artWorkUrl), placeholderImage: UIImage(named: "placeholder.png"))
    }
}
