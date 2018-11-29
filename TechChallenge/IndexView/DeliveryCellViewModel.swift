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

  public var cellType: UITableViewCell.Type = DeliveryCell.self
  public let height: CGFloat = 50
  public let reuseIdentifier: String = "DeliveryCell"

  public let delivery: Delivery

  init(delivery: Delivery) {
    self.delivery = delivery
  }
}
