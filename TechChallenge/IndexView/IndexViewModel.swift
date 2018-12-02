//
//  IndexViewModel.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import RxSwift

public class IndexViewModel: TableViewModel {

  private let disposeBag = DisposeBag()
  public var objects: [TableViewCellViewModel] {
    didSet {
      objectPs.onNext(())
    }
  }
  private let objectPs = PublishSubject<Void>()
  public var objectObs: Observable<Void> {
    return objectPs.asObservable()
  }

  /* indicates waiting for the next batch of deliveries*/
  public var gettingNext: Bool = false
  /* indicates there are no more deliveries to view */
  public var viewedAllDeliveries: Bool = false

  public init() {
    self.objects = [TableViewLoadingCellViewModel()]

    getDeliveries(offset: 0, limit: 20)
      .subscribe(onNext: { [weak self] deliveries in
        guard let strongSelf = self else { return }
        let ogTableViewData = strongSelf.tableViewDataForDeliveries(deliveries)
        strongSelf.objects = ogTableViewData + [TableViewLoadingCellViewModel()]
      }, onError: { [weak self] (error) in
        guard let strongSelf = self else { return }
        let errorContent = strongSelf.contentForError(error: error)
        strongSelf.objects = errorContent
      })
      .disposed(by: disposeBag)
  }

  private func getDeliveries(offset: Int,
                             limit: Int) -> Observable<[Delivery]> {
    return dataLoader()
      .getDeliveries(offset: 0, limit: limit)
      .observeOn(MainScheduler.instance)
  }

  public func appendDeliveries(offset: Int,
                               limit: Int) {
    gettingNext = true
    getDeliveries(offset: offset,
                  limit: limit)
      .subscribe(onNext: { [weak self] deliveries in
        guard let strongSelf = self else { return }
        let nextTableViewData = strongSelf.tableViewDataForDeliveries(deliveries)
        var objects = strongSelf.objects
         strongSelf.viewedAllDeliveries = objects.isEmpty
        let nextContent: [TableViewCellViewModel] = nextTableViewData
        objects.insert(contentsOf: nextContent, at: offset - 1)
        if strongSelf.viewedAllDeliveries {
          //Remove loading indicator as there are no more deliveries
          objects.removeLast()
        }
        strongSelf.objects = objects
        }, onError: { [weak self] error in
          guard let strongSelf = self else { return }
          let errorContent = strongSelf.contentForError(error: error)
          var objects = strongSelf.objects
          objects.removeLast()
          objects.append(contentsOf: errorContent)
          strongSelf.objects = objects
        },
           onCompleted: { [weak self] in
          guard let strongSelf = self else { return }
          strongSelf.gettingNext = false
      })
      .disposed(by: disposeBag)
  }

  private func contentForError(error: Error) -> [TableViewCellViewModel] {
    let errorCVM: TableViewErrorCellViewModel
    if let error = error as? AppError {
      errorCVM = TableViewErrorCellViewModel(error: error)
    } else {
      errorCVM = TableViewErrorCellViewModel(error: APIError.unknown)
    }
    return [errorCVM]
  }

  private func tableViewDataForDeliveries(_ deliveries: [Delivery]) -> [TableViewCellViewModel] {
    var newObjects: [TableViewCellViewModel] = []
    for delivery in deliveries {
      newObjects.append(DeliveryCellViewModel(delivery: delivery))
    }
    return newObjects
  }
}
