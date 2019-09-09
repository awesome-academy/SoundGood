//
//  PlaylistViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/30/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import Reusable

final class PlaylistViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var playlistTableView: UITableView!

    // MARK: - Variables
    private var playlists = [Playlist]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Playlist"
    }

    private func setupTableView() {
        playlistTableView.dataSource = self
        playlistTableView.delegate = self
        playlistTableView.register(cellType: TrackTableViewCell.self)
    }
}

// MARK: - TableView Datasource
extension PlaylistViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return playlists.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists[section].tracks.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return playlists[section].name
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TrackTableViewCell
        cell.setup(track: playlists[indexPath.section].tracks[indexPath.row])
        return cell
    }
}

// MARK: - TableView Delegate
extension PlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - StoryboardSceneBased
extension PlaylistViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.playlist
}
