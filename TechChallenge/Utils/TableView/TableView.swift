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

      if let tableViewCell = dequeue(tableView: tableView, indexPath: indexPath, cvm: cvm) {
        tableViewCell.selectionStyle = .none
        cell = tableViewCell
      } else {
        fatalError("Failed to dequeue")
      }
    } else {
      fatalError("[ERROR] CVM does not exist")
    }

    return cell
  }

  private func dequeue(tableView: UITableView,
                       indexPath: IndexPath,
                       cvm: TableViewCellViewModel)
    -> UITableViewCell? {

      /*NOTE: To avoid `over-engeering` as the project spec states and considering the use case for this task is quite simple and only has one cell type... just use a basic switch. If you add more cellvm/cell types, add to this switch to dequeue successfully.

       Personally, I would recommend something liek IGListKit or your own binding class to help with the binding in a more complex app. */

      return cvm.dequeueAndBind(tableView: tableView, indexPath: indexPath)
  }
  // MARK: TableViewDelegate

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let cvm = viewModel?.objects[safe: indexPath.row] else {
      return 0
    }

    return cvm.calcHeight()
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }

  public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    print("TODO")
  }
}
