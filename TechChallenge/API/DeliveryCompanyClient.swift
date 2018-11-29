//
//  DeliveryCompanyClient.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

public class DeliveryCompanyClient: APIClient {

  public let domain: URL

  public required init(configuration: APIClientConfiguration) {
    self.domain = configuration.endpoint
  }

  public func getDeliveries(offset: Int, limit: Int) {

    let kOffsetKey = "offset"
    let kLimitKey = "limit"
    let kEndpoint = "deliveries"
    Alamofire.request("\(domain.absoluteString)/\(kEndpoint)", method: .get, parameters: [kOffsetKey: offset, kLimitKey: limit], encoding:  JSONEncoding.default).responseJSON { response in
      print("result: \(response.result.value)")
    }
  }
}
