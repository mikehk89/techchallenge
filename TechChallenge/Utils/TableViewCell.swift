//
//  TableViewCell.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import UIKit

public class TableViewCell<TableViewCellViewModel>: UITableViewCell {

  internal var viewModel: TableViewCellViewModel? {
    didSet {
      didUpdate(viewModel: viewModel)
    }
  }

  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func setup() {

  }

  public func didUpdate(viewModel: TableViewCellViewModel?) {

  }
}
