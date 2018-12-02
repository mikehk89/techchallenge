//
//  DeliveryCompanyClient.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift
import UIKit

public class DeliveryCompanyClient: APIClient {

  public let domain: URL

  public required init(configuration: APIClientConfiguration) {
    self.domain = configuration.endpoint
  }

  public func getDeliveries(offset: Int, limit: Int) -> Observable<[Delivery]> {

    let kOffsetKey = "offset"
    let kLimitKey = "limit"
    let kEndpoint = "deliveries"

    let requestUrl = "\(self.domain.absoluteString)/\(kEndpoint)"
    return Observable<[Delivery]>.create({ observer -> Disposable in
      let request = Alamofire.request(requestUrl, method: .get, parameters: [kOffsetKey: offset, kLimitKey: limit], encoding:  JSONEncoding.default)
      
      request.responseJSON(completionHandler: { response in
        if let dictArr = response.result.value as? [[String: Any]] {
          var deliveries: [Delivery] = []
          for dict in dictArr {
            if let delivery = Delivery(dict: dict) {
              deliveries.append(delivery)
            }
          }
          observer.onNext(deliveries)
          observer.onCompleted()
        } else if let error = response.error {
          observer.onError(APIError(error: error))
        }
      })

      let disposable = Disposables.create {
        request.cancel()
      }

      return disposable
    })
  }
}
