//
//  DeliveryCell.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

public class DeliveryCell: TableViewCell<DeliveryCellViewModel> {

  private struct Dimensions {
    static let kLeftRightMargin: CGFloat = 20
    static let kImageViewLeft: CGFloat = 10
    static let kTopBottomMargin: CGFloat = 10
    static let kImageViewSize: CGSize = CGSize(width: 30, height: 30)
  }

  lazy var descriptionLabel: UILabel = {
    let descriptionLabel = UILabel()
    descriptionLabel.numberOfLines = 0
    return descriptionLabel
  }()

  public lazy var deliveryImageView: UIImageView = {
    return UIImageView()
  }()

  public override func setup() {
    super.setup()
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(deliveryImageView)
  }

  public override func didUpdate(viewModel: DeliveryCellViewModel?) {
    descriptionLabel.text = viewModel?.delivery.description
    if let urlStr =
      viewModel?.delivery.imageUrl,
      let url = URL(string: urlStr) {
      deliveryImageView.kf.setImage(with: url)
    } else {
      deliveryImageView.image = nil
    }
  }

  public override func layoutSubviews() {
    super.layoutSubviews()

    deliveryImageView.frame
      = CGRect(x: contentView.bounds.size.width
        - Dimensions.kLeftRightMargin
        - Dimensions.kImageViewSize.width,
               y: contentView.bounds.midY - Dimensions.kImageViewSize.height * 0.5,
               width: Dimensions.kImageViewSize.width,
               height: Dimensions.kImageViewSize.height)

    let maxDescriptionWidth = deliveryImageView.frame.minX - Dimensions.kImageViewLeft
    let descriptionLabelSize = descriptionLabel.sizeThatFits(CGSize(width: maxDescriptionWidth, height: CGFloat.infinity))

    descriptionLabel.frame
      = CGRect(x: Dimensions.kLeftRightMargin,
               y: Dimensions.kTopBottomMargin,
               width: descriptionLabelSize.width,
               height: descriptionLabelSize.height)


  }
}
