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

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Home"
    }

    @IBAction func segmentActionChanged(_ sender: Any) {
        trackTableView.reloadData()
    }

    private func setupTableView() {
        trackTableView.dataSource = self
        trackTableView.register(cellType: TrackTableViewCell.self)
    }
}

// MARK: - Table view data source
extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackTableViewCell = trackTableView.dequeueReusableCell(for: indexPath)
        return cell
    }
}
