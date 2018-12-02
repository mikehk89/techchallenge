//
//  DetailViewController.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import UIKit

public class DetailViewController: UIViewController {

  public var detailView: DetailView {
    return self.view as! DetailView
  }
  
  public override func loadView() {
    self.view = DetailView()
  }
}
