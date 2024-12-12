//
//  TodoListViewController + UISearchResultsUpdating.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

import UIKit

extension TodoListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else { return }
    presenter.filteredItems(searchText: searchText)
    animateTableViewUpdates(with: .automatic)
  }
}
