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
    self.viewModel = viewModel
    viewModel.objectObs
      .subscribe(onNext: { [weak self] _ in
        guard let strongSelf = self else { return }
        strongSelf.tableView.reloadData()
      })
      .disposed(by: disposeBag)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let deliveryCVM = viewModel?.objects[safe: indexPath.row] as? DeliveryCellViewModel,
      let location = deliveryCVM.delivery.location {
      let detailViewModel = DetailViewModel(location: location)
      coordinator.transitTo(screen: .detail(detailViewModel), transition: .modal)
    }
  }

  public override func tableView(_ tableView: UITableView,
                        willDisplay cell: UITableViewCell,
                        forRowAt indexPath: IndexPath) {
    guard tableView.numberOfRows(inSection: indexPath.section) > 1 else { return }
    let numberOfRows = tableView.numberOfRows(inSection: indexPath.section)

    //Paginate at 80%
    let scrollPercent = CGFloat(indexPath.row + 1) / CGFloat(numberOfRows)
    if scrollPercent > 0.9 && (viewModel?.gettingNext ?? true) == false {
      viewModel?.appendDeliveries(offset: numberOfRows, limit: 20)
    }
  }
}
