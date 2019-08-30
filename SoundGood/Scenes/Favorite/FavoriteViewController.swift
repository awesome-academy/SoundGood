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
    @IBOutlet private weak var favoriteImage: UIImageView! {
        didSet {
            self.favoriteImage.tappable = true
        }
    }
    @IBOutlet private weak var playlistImage: UIImageView! {
        didSet {
            self.playlistImage.tappable = true
        }
    }
    @IBOutlet private weak var historyImage: UIImageView! {
        didSet {
            self.historyImage.tappable = true
        }
    }
    @IBOutlet weak var historyTableView: UITableView!

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

    @IBAction func navigateToFavorites(_ sender: Any) {
    }

    @IBAction func navigateToPlaylists(_ sender: Any) {
    }

    @IBAction func navigateToHistory(_ sender: Any) {
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
