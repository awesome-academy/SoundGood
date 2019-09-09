//
//  TrackByGenreViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/28/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import Reusable

final class TrackByGenreViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var trackTableView: UITableView!

    // MARK: - Variables
    var genre = Genre(key: "", title: "")
    private let viewModel: TrackByGenreViewModel = {
        let remote = TrackRemoteDataSource(apiService: ApiService.shared)
        let repository = TrackDataRepository(remoteDataSource: remote)
        let viewModel = TrackByGenreViewModel(repository: repository)
        return viewModel
    }()
    private let refreshControl = UIRefreshControl()
    private var tracks = [Track]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = genre.title
    }

    deinit {
        viewModel.trackObservable.dispose()
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
        getData { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.trackTableView.reloadData()
        }
    }

    private func getData(completion: (() -> Void)? = nil) {
        viewModel.getTrackByGenre(with: genre.key)
        observeData(completion: completion)
    }

    private func observeData(completion: (() -> Void)? = nil) {
        viewModel.trackObservable.subscribe(DispatchQueue.main) { [weak self] result in
            guard let response = result else { return }
            switch response {
            case .success(let trackResponse):
                guard let collection = trackResponse?.trackCollection else { return }
                var data = [Track]()
                for item in collection {
                    data.append(item.track)
                }
                self?.updateTracks(data: data)
                completion?()
            case .failure(let error):
                guard let error = error else { return }
                self?.showErrorAlert(message: error.errorMessage)
            }
        }
    }

    private func updateTracks(data: [Track]) {
        tracks = data
        trackTableView.reloadData()
    }
}

// MARK: - TableView DataSource
extension TrackByGenreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackTableViewCell = trackTableView.dequeueReusableCell(for: indexPath)
        if tracks.indices.contains(indexPath.row) {
            cell.setup(track: tracks[indexPath.row])
        }
        return cell
    }
}

// MARK: - TableView Delegate
extension TrackByGenreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableViewConstant.heightForTableViewCell)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - StoryboardSceneBased
extension TrackByGenreViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.trackByGenre
}
