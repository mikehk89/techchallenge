//
//  TableViewController.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

public class TableView<ViewModel: TableViewModel>: UIView, UITableViewDataSource, UITableViewDelegate {

  public let disposeBag = DisposeBag()
  public lazy var tableView: UITableView = {
    let tableView = UITableView()
    return tableView
  }()

  public var viewModel: ViewModel? {
    didSet {
      didUpdate(viewModel: viewModel)
    }
  }

  public init() {
    super.init(frame: .zero)
    setup()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func setup() {
    tableView.dataSource = self
    tableView.delegate = self
    addSubview(tableView)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    tableView.frame = bounds
  }

  /* Intention is to override to child classes
   * and to subscribe to events specific to the
   * child class VM */
  public func didUpdate(viewModel: ViewModel?) {

  }

  // MARK: TableViewDatasource

  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.objects.count ?? 0
  }

  public func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell: UITableViewCell
    if let viewModel = viewModel,
      let cvm = viewModel.objects[safe: indexPath.row] {
      let reuseId = cvm.reuseIdentifier
      tableView.register(cvm.cellType, forCellReuseIdentifier: reuseId)

      //TODO: remove the hard
      if let testcell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? DeliveryCell,
        let dcvm = cvm as? DeliveryCellViewModel {
        testcell.didUpdate(viewModel: dcvm)
        cell = testcell
      } else {
        fatalError("Failed to dequeue")
      }
    } else {
      fatalError("[ERROR] CVM does not exist")
    }

    return cell
  }

  // MARK: TableViewDelegate

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let cvm = viewModel?.objects[safe: indexPath.row] else {
      return 0
    }

    return cvm.height
  }
}
