//
//  TrackByGenreViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/28/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit

final class TrackByGenreViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var trackTableView: UITableView!
    
    // MARK: - Variables
    var genreTitle = ""

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = genreTitle
    }
}

// MARK: - TableView DataSource
extension TrackByGenreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackTableViewCell = trackTableView.dequeueReusableCell(for: indexPath)
        return cell
    }
}
