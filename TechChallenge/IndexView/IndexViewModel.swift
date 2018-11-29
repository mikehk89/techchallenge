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

  public init() {
    self.objects = []

    dataLoader().getDeliveries(offset: 0, limit: 10).observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] deliveries in
        guard let strongSelf = self else { return }
        var newObjects: [TableViewCellViewModel] = []
        for delivery in deliveries {
          newObjects.append(DeliveryCellViewModel(delivery: delivery))
        }
        strongSelf.objects = newObjects
      })
      .disposed(by: disposeBag)
  }
}
