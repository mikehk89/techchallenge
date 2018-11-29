//
//  IndexViewModel.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation

public class IndexViewModel: TableViewModel {
  public var objects: [TableViewCellViewModel]

  public init() {
    objects = [DeliveryCellViewModel(),
               DeliveryCellViewModel(),
               DeliveryCellViewModel()]
  }
}
