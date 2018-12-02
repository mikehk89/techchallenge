//
//  TableViewErrorCell.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 2/12/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import UIKit

public class TableViewErrorCell: TableViewCell<TableViewErrorCellViewModel> {

  private struct Dimensions {
    static let kLRMargin: CGFloat = 20
  }
  public lazy var errorLabel: UILabel = {
    let errorLabel = UILabel()
    errorLabel.textColor = .red
    errorLabel.numberOfLines = 1
    return errorLabel
  }()

  public override func setup() {
    super.setup()
    contentView.addSubview(errorLabel)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    let errorLabelSize = errorLabel.sizeThatFits(CGSize(width: contentView.bounds.size.width - 2 * Dimensions.kLRMargin, height: contentView.bounds.size.height))

    errorLabel.frame = CGRect(x: Dimensions.kLRMargin, y: contentView.bounds.midY - errorLabel.bounds.size.height * 0.5, width: contentView.bounds.size.width - 2 * Dimensions.kLRMargin,
                              height: errorLabelSize.height)
  }
}
