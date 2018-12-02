//
//  TableViewErrorCellViewModel.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 2/12/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import UIKit

public class TableViewErrorCellViewModel: TableViewCellViewModel {
  public var reuseIdentifier: String {
    return "ErrorCell"
  }

  public var cellType: UITableViewCell.Type {
    return TableViewErrorCell.self
  }

  let error: AppError
  let errorText: String

  init(error: AppError) {
    self.error = error
    errorText = error.uiDisplayText
  }

  public func calcHeight() -> CGFloat {
    return 50
  }

  public func dequeueAndBind(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
    let binder = TableViewBinder<TableViewErrorCellViewModel, TableViewErrorCell>(viewModel: self, tableView: tableView, indexPath: indexPath)
    return binder.dequeueAndBind()
  }
}
