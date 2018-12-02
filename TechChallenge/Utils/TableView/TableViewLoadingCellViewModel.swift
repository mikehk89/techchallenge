//
//  TableViewLoadingCellViewModel.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 2/12/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import UIKit

public class TableViewLoadingCellViewModel: TableViewCellViewModel {
  public var reuseIdentifier: String {
    return "LoadingCell"
  }

  public var cellType: UITableViewCell.Type {
    return TableViewLoadingCell.self
  }

  public func calcHeight() -> CGFloat {
    return 50
  }

  public func dequeueAndBind(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
    let binder = TableViewBinder<TableViewLoadingCellViewModel, TableViewLoadingCell>(viewModel: self, tableView: tableView, indexPath: indexPath)
    return binder.dequeueAndBind()
  }
}
