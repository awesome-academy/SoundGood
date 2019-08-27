//
//  GenreTableViewCell.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/26/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import Reusable

final class GenreTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var genreTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(title: String) {
        genreTitleLabel.text = title
    }
}
