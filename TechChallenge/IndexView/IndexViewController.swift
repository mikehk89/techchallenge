//
//  ViewController.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import UIKit

public class IndexViewController: UIViewController {

  public var indexView: IndexView {
    return self.view as! IndexView
  }

  public override func loadView() {
    self.view = IndexView()
  }
}
