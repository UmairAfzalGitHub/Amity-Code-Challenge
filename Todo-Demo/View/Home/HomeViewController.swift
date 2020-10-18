//  Created by Umair Afzal
//  Copyright © 202 Amity.co. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit
import EventKit

class HomeViewController: BaseViewController {
    
    // MARK: - Variables & Outlets
    
    @IBOutlet weak var tableView: UITableView!

    var sections = [String]()

    var viewModel = HomeViewModel()

    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        self.title = "Home"

        populateViewWithData()
    }

    func populateViewWithData() {
        viewModel.getTasks()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if viewModel.isLoading {
            return 0
        }
        
        if viewModel.filteredDataSource.count == 0 {
            tableView.showEmptyView()
            return 0
        }
        
        self.tableView.backgroundView = UIView()
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TaskListingTableViewCell.cellForTableView(tableView: tableView, atIndexPath: indexPath)
        cell.configureCell(task: viewModel.filteredDataSource[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskDetailViewController = TaskDetailsViewController()
        taskDetailViewController.viewModel.dataSource = viewModel.filteredDataSource[indexPath.row]
        self.navigationController?.pushViewController(taskDetailViewController, animated: true)
    }
}

// MARk: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {

    func didLoadTasks() {
        self.tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterTasks(with: searchText)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filterTasks(with: searchBar.text.orEmpty)
    }

    /// A function that filters data from the dataSource's title and description fields
    /// - Parameter searchText: search query
    private func filterTasks(with searchText: String) {
        if searchText.isEmpty {
            viewModel.filteredDataSource = viewModel.dataSource
        } else {
            // filter data based on search bar search text
            viewModel.filteredDataSource = viewModel.dataSource.filter({ $0.title.localizedCaseInsensitiveContains(searchText)
                || $0.description.localizedCaseInsensitiveContains(searchText)
            })
        }

        tableView.reloadData()
    }
}
