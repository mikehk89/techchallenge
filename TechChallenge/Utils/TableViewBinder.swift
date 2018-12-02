//
//  TableViewBinder.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 2/12/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import UIKit

public class TableViewBinder<ViewModelType: TableViewCellViewModel, CellType: TableViewCell<ViewModelType>> {

  public let tableView: UITableView
  public let viewModel: ViewModelType
  public let indexPath: IndexPath

  public init(viewModel: ViewModelType,
              tableView: UITableView,
              indexPath: IndexPath) {
    self.viewModel = viewModel
    self.tableView = tableView
    self.indexPath = indexPath
  }

  public func dequeueAndBind() -> CellType? {
    let cell = tableView
      .dequeueReusableCell(withIdentifier: viewModel.reuseIdentifier,
                           for: indexPath) as? CellType

    cell?.didUpdate(viewModel: viewModel)
    return cell
  }
}
