//
//  HomeViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/23/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var trackTableView: UITableView!

    // MARK: - Variables
    private let viewModel: HomeViewModel = {
        let remote = TrackRemoteDataSource(apiService: ApiService.shared)
        let repository = TrackDataRepository(remoteDataSource: remote)
        let viewModel = HomeViewModel(repository: repository)
        return viewModel
    }()
    private let refreshControl = UIRefreshControl()
    private var tracks = [Track]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Home"
    }

    @IBAction func segmentActionChanged(_ sender: Any) {
        getData()
    }

    private func setupTableView() {
        trackTableView.dataSource = self
        trackTableView.delegate = self
        trackTableView.register(cellType: TrackTableViewCell.self)
        if #available(iOS 10.0, *) {
            trackTableView.refreshControl = refreshControl
        } else {
            trackTableView.addSubview(refreshControl)
        }
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }

    @objc private func reloadData() {
        tracks = [Track]()
        getData()
        refreshControl.endRefreshing()
    }

    private func getData() {
        var kind = ""
        switch segmentController.titleForSegment(at: segmentController.selectedSegmentIndex) {
        case "New & Hot":
            kind = "trending"
        default:
            kind = "top"
        }
        viewModel.getHomeTracks(kind: kind) { [weak self] (response, _) in
            guard let response = response else { return }
            DispatchQueue.main.async {
                self?.tracks = response
                self?.trackTableView.reloadData()
            }
        }
    }
}

// MARK: - Table view data source
extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackTableViewCell = trackTableView.dequeueReusableCell(for: indexPath)
        if !tracks.isEmpty {
            cell.setup(track: tracks[indexPath.row])
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableViewConstant.heightForTableViewCell)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
