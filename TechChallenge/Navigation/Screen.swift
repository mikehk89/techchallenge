//
//  Screen.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 2/12/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import UIKit

enum Screen {
  case list
  case detail(DetailViewModel)
}

extension Screen {
  func viewController() -> UIViewController {
    switch self {
    case .list:
      return IndexViewController()
    case .detail(let viewModel):
      let detailVC = DetailViewController()
      detailVC.detailView.viewModel = viewModel
      return detailVC
    }
  }
}
