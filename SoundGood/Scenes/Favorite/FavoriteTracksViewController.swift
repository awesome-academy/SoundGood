//
//  FavoriteTracksViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/30/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit

class FavoriteTracksViewController: UIViewController {
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    private var favoriteTracks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Favorite tracks"
    }
    
}

// MARK: TableView Datasource
extension FavoriteTracksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(for: indexPath) as TrackTableViewCell
    }
}

// MARK: TableView Delegate
extension FavoriteTracksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
