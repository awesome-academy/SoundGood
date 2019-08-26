//
//  HomeViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/23/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var trackTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        trackTableView.dataSource = self
        trackTableView.register(cellType: TrackTableViewCell.self)
    }

    @IBAction func segmentActionChanged(_ sender: Any) {
        trackTableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackTableViewCell = trackTableView.dequeueReusableCell(for: indexPath)
        return cell
    }
}
