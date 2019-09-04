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

    func setup(track: Track) {
        trackTitle.text = track.title
        trackArtist.text = track.artist
        if let artwork = track.artWorkUrl, let url = URL(string: artwork) {
            loadImageFromUrl(url: url)
        }
    }

    private func loadImageFromUrl(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                self.trackImage.image = image
            }
        }.resume()
    }
}
