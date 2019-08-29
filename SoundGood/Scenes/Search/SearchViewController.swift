//
//  SearchViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/28/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var trackSearchBar: UISearchBar!
    @IBOutlet weak var trackResultTableView: UITableView!

    // MARK: - Variables
    private var searchedTracks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Search"
    }

    private func setupSearchBar() {
        trackSearchBar.delegate = self
    }

    private func setupTableView() {
        trackResultTableView.dataSource = self
        trackResultTableView.delegate = self
        trackResultTableView.register(cellType: TrackTableViewCell.self)
    }
}

// MARK: - TableView DataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedTracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return trackResultTableView.dequeueReusableCell(for: indexPath) as TrackTableViewCell
    }
}

// MARK: - TableView Delegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchRequest(_:)), object: searchBar)
        perform(#selector(searchRequest(_:)), with: searchBar, afterDelay: Constant.searchDelay)
    }

    @objc func searchRequest(_ searchBar: UISearchBar) {
        trackResultTableView.isHidden = searchBar.text?.isEmpty ?? true
        guard let query = searchBar.text, !query.isEmpty else {
            return
        }
        print(query)
        trackResultTableView.reloadData()
    }
}
