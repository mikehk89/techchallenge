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

public protocol APIQuery {
  var url: String { get }
  var params: [String: Any] { get }
}

public struct GetDeliveryQuery: APIQuery {
  public var url: String
  public var params: [String : Any]
}

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
    let deliveryQuery = GetDeliveryQuery(url: requestUrl, params: [kOffsetKey: offset, kLimitKey: limit])
    return fetch(query: deliveryQuery,
                 transformer: { (dictArr) -> [Delivery] in
                  var deliveries: [Delivery] = []
                  for dict in dictArr {
                    if let delivery = Delivery(dict: dict) {
                      deliveries.append(delivery)
                    }
                  }
                  return deliveries
    })
  }

  public func fetch<Query: APIQuery, ResultType>(query: Query,
                                                 transformer: @escaping ([[String: Any]]) throws ->  [ResultType]) -> Observable<[ResultType]> {
    return Observable<[ResultType]>.create({ observer -> Disposable in
      let request = Alamofire.request(query.url, method: .get, parameters: query.params, encoding:  JSONEncoding.default)

      request.responseJSON(completionHandler: { response in
        if let dictArr = response.result.value as? [[String: Any]] {
          do {
            let result = try transformer(dictArr)
            observer.onNext(result)
            observer.onCompleted()
          } catch {
            observer.onError(ParsingError())
          }
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
