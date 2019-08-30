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
        favoriteImage.tapAction = { [weak self] in
            self?.navigateToFavorites()
        }
        playlistImage.tapAction = { [weak self] in
            self?.navigateToPlaylists()
        }
        historyImage.tapAction = { [weak self] in
            self?.navigateToHistory()
        }
    }

    private func setupTableView() {
        historyTableView.register(cellType: TrackTableViewCell.self)
        historyTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.isHidden = listenedTracks.isEmpty
    }

    private func navigate(controller: UIViewController) {
        guard let view = navigationController?.view else { return }
        UIView.transition(with: view, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
        navigationController?.pushViewController(controller, animated: false)
    }

    private func navigateToFavorites() {
        guard let controller = Storyboards.favoriteTracks.instantiateInitialViewController() as? FavoriteTracksViewController else { return }
        navigate(controller: controller)
    }

    private func navigateToPlaylists() {
        guard let controller = Storyboards.playlist.instantiateInitialViewController() as? PlaylistViewController else { return }
        navigate(controller: controller)
    }

    private func navigateToHistory() {
        guard let controller = Storyboards.history.instantiateInitialViewController() as? HistoryViewController else { return }
        navigate(controller: controller)
    }

    @IBAction func navigateToFavorites(_ sender: Any) {
        navigateToFavorites()
    }

    @IBAction func navigateToPlaylists(_ sender: Any) {
        navigateToPlaylists()
    }

    @IBAction func navigateToHistory(_ sender: Any) {
        navigateToHistory()
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
