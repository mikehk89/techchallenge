//
//  TableViewLoadingCell.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 2/12/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import UIKit

public class TableViewLoadingCell: TableViewCell<TableViewLoadingCellViewModel> {

  private lazy var loadingIndicator: UIActivityIndicatorView = {
    let loadingIndicator = UIActivityIndicatorView(style: .gray)
    return loadingIndicator
  }()

  public override func setup() {
    super.setup()
    contentView.addSubview(loadingIndicator)
    loadingIndicator.startAnimating()
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    loadingIndicator.frame
      = CGRect(x: contentView.bounds.midX - loadingIndicator.bounds.size.width * 0.5,
               y: contentView.bounds.midY - loadingIndicator.bounds.size.height * 0.5,
               width: loadingIndicator.bounds.size.width,
               height: loadingIndicator.bounds.size.height)
  }

  public override func prepareForReuse() {
    super.prepareForReuse()
    loadingIndicator.startAnimating()
  } 
}
