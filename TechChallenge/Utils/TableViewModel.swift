//
//  TableViewModel.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import UIKit

public protocol TableViewModel {
  var objects: [TableViewCellViewModel] { get }
}

public protocol TableViewCellViewModel { 

  var reuseIdentifier: String { get }
  var cellType: UITableViewCell.Type { get }

  func calcHeight() -> CGFloat
  func dequeueAndBind(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell?
}
