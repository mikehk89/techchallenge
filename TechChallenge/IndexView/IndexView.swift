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

  public override func setup() {
    super.setup()
    self.viewModel = IndexViewModel()
  }
}
