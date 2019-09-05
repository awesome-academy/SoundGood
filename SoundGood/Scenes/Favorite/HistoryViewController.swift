//
//  HistoryViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/3/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import Reusable

class HistoryViewController: UIViewController {

    @IBOutlet private weak var historyTableView: UITableView!

    private var historyTracks = [Track]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setClearButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "History"
    }

    private func setupTableView() {
        historyTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.register(cellType: TrackTableViewCell.self)
        historyTableView.isHidden = historyTracks.isEmpty
    }

    private func setClearButton() {
        let clearButton = UIBarButtonItem(title: "CLEAR ALL", style: .plain, target: self, action: #selector(clearHistory))
        navigationItem.rightBarButtonItem = clearButton
    }

    @objc func clearHistory() {
        historyTracks.removeAll()
        historyTableView.reloadData()
    }
}

// MARK: TableView datasource
extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyTracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TrackTableViewCell
        cell.setup(track: historyTracks[indexPath.row])
        return cell
    }
}

// MARK: TableView delegate
extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: StoryboardSceneBased
extension HistoryViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.history
}
