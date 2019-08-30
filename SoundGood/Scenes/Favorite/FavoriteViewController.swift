//
//  FavoriteViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/29/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var favoriteImage: UIImageView!
    @IBOutlet private weak var playlistImage: UIImageView!
    @IBOutlet private weak var historyImage: UIImageView!
    @IBOutlet private weak var historyTableView: UITableView!

    // MARK: - Variables
    private var listenedTracks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageViews()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Favorite"
    }

    private func setupImageViews() {
        favoriteImage.tapAction = {
            self.navigateToFavorites(self)
        }
        playlistImage.tapAction = {
            self.navigateToPlaylists(self)
        }
        historyImage.tapAction = {
            self.navigateToHistory(self)
        }
    }

    private func setupTableView() {
        historyTableView.register(cellType: TrackTableViewCell.self)
        historyTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.isHidden = listenedTracks.isEmpty
    }
    
    @IBAction func navigateToFavorites(_ sender: Any) {
    }
    
    @IBAction func navigateToPlaylists(_ sender: Any) {
    }
    
    @IBAction func navigateToHistory(_ sender: Any) {
    }

}

// MARK: - TableView datasource
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.numberOfHistoryTrackDisplay
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(for: indexPath) as TrackTableViewCell
    }
}

// MARK: - TableView Delegate
extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
