//
//  IndexView.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import UIKit

public class IndexView: TableView<IndexViewModel> {

  public init(viewModel: IndexViewModel = IndexViewModel()) {
    super.init()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
