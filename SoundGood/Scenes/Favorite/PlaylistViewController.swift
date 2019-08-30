//
//  PlaylistViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/30/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var playlistTableView: UITableView!

    // MARK: - Variables
    private var playlists = [Playlist]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        playlists = getPlaylists()
    }

    private func setupTableView() {
        playlistTableView.dataSource = self
        playlistTableView.delegate = self
        playlistTableView.register(cellType: TrackTableViewCell.self)
    }

    private func getPlaylists() -> [Playlist] {
        var list = [Playlist]()
        list.append(Playlist(name: "First", tracks: [Track(name: "Love the way you lie"),
                                                     Track(name: "Another thing")]))
        list.append(Playlist(name: "Second", tracks: [Track(name: "Love the way you lie"),
                                                     Track(name: "Another thing"),
                                                     Track(name: "Initialize")])
        )
        return list
    }
}

// MARK: - TableView Datasource
extension PlaylistViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return playlists.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists[section].tracks?.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return playlists[section].name
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TrackTableViewCell
        cell.setup(imageUrl: playlists[indexPath.section].tracks?[indexPath.row].name ?? "",
                   title: playlists[indexPath.section].tracks?[indexPath.row].name ?? "",
                   artist: playlists[indexPath.section].tracks?[indexPath.row].name ?? "")
        return cell
    }
}

// MARK: - TableView Delegate
extension PlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
