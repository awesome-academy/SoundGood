//
//  FavoriteViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/29/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import Reusable

class FavoriteViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var favoriteImageView: UIImageView!
    @IBOutlet private weak var playlistImageView: UIImageView!
    @IBOutlet private weak var historyImageView: UIImageView!
    @IBOutlet private weak var historyTableView: UITableView!

    // MARK: - Variables
    private var listenedTracks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageViews()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Favorite"
    }

    private func setupImageViews() {
        let favoriteTapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToFavorites(_:)))
        let playlistTapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToPlaylists(_:)))
        let historyTapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToHistory(_:)))
        favoriteImageView.addGestureRecognizer(favoriteTapGesture)
        playlistImageView.addGestureRecognizer(playlistTapGesture)
        historyImageView.addGestureRecognizer(historyTapGesture)
    }

    private func setupTableView() {
        historyTableView.register(cellType: TrackTableViewCell.self)
        historyTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.isHidden = listenedTracks.isEmpty
    }

    private func navigate(controller: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        guard let view = navigationController?.view else { return }
        view.window?.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(controller, animated: false)
    }

    @IBAction func navigateToFavorites(_ sender: Any) {
        let controller = FavoriteTracksViewController.instantiate()
        favoriteImageView.isHighlighted = false
        navigate(controller: controller)
    }

    @IBAction func navigateToPlaylists(_ sender: Any) {
        let controller = PlaylistViewController.instantiate()
        playlistImageView.isHighlighted = false
        navigate(controller: controller)
    }

    @IBAction func navigateToHistory(_ sender: Any) {
        let controller = HistoryViewController.instantiate()
        historyImageView.isHighlighted = false
        navigate(controller: controller)

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

// MARK: - StoryboardScenceBased
extension FavoriteViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.favorite
}
