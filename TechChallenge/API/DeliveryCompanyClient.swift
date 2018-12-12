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

  private lazy var cacheSessionManager: Alamofire.SessionManager = {
    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = .returnCacheDataDontLoad
    return Alamofire.SessionManager(configuration: configuration)
  }()

  private lazy var networkSessionManager: Alamofire.SessionManager = {
    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = .reloadIgnoringCacheData
    return Alamofire.SessionManager(configuration: configuration)
  }()

  public required init(configuration: APIClientConfiguration) {
    self.domain = configuration.endpoint
  }

  public func getDeliveries(offset: Int, limit: Int) -> Observable<[Delivery]> {

    let kOffsetKey = "offset"
    let kLimitKey = "limit"
    let kEndpoint = "deliveries"
    let requestUrl = "\(self.domain.absoluteString)/\(kEndpoint)"
    let deliveryQuery = GetDeliveryQuery(url: requestUrl, params: [kOffsetKey: offset, kLimitKey: limit])
    let transformer: (([[String: Any]]) -> [Delivery]) = { dictArr -> [Delivery] in

      var deliveries: [Delivery] = []
      for dict in dictArr {
        if let delivery = Delivery(dict: dict) {
          deliveries.append(delivery)
        }
      }
      return deliveries
    }

    let cacheData = fetch(sessionManager: cacheSessionManager, query: deliveryQuery, transformer: transformer)

    //Network session manager will fallback on the cache SM when there is an error
    let networkData = fetch(sessionManager: networkSessionManager, query: deliveryQuery, transformer: transformer)
      .catchError { error -> Observable<[Delivery]> in
        return cacheData
    }

    if NetworkReachabilityManager()?.isReachable ?? false {
      return networkData
    } else {
      return cacheData
    }
  }

  public func fetch<Query: APIQuery, ResultType>(sessionManager: SessionManager,
                                                 query: Query,
                                                 transformer: @escaping ([[String: Any]]) throws ->  [ResultType]) -> Observable<[ResultType]> {

    return Observable<[ResultType]>.create({ observer -> Disposable in
      let request
        = sessionManager.request(query.url,
                                 method: .get,
                                 parameters: query.params)
      request.responseJSON(completionHandler: { response in
        if let dictArr = response.result.value as? [[String: Any]] {
          do {
            let result = try transformer(dictArr)
            observer.onNext(result)
            observer.onCompleted()
          } catch {
            print("[APIError-Parsing]")
            observer.onError(APIError.parsing)
          }
        } else if let error = response.error {
          print("[APIError-fetch] \(error.localizedDescription)")
          observer.onError(APIError.fetchError(error))
        } else {
          print("[APIError-unknown]")
          observer.onError(APIError.unknown)
        }
      })
      let disposable = Disposables.create {
        request.cancel()
      }
      return disposable
    })
  }
}
