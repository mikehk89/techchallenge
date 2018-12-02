//
//  DeliveryCellViewModel.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import UIKit

public class DeliveryCellViewModel: TableViewCellViewModel {

  public var cellType: UITableViewCell.Type {
    return DeliveryCell.self
  }

  public var reuseIdentifier: String {
    return "DeliveryCell"
  }

  public let delivery: Delivery

  init(delivery: Delivery) {
    self.delivery = delivery
  }

  public func calcHeight() -> CGFloat {
    return 50
  }

  public func dequeueAndBind(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {

    let binder = TableViewBinder<DeliveryCellViewModel, DeliveryCell>(viewModel: self, tableView: tableView, indexPath: indexPath)
    return binder.dequeueAndBind()
  }
}
