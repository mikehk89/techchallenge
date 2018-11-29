//
//  APIClient.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import RxSwift

/* Implement as many clients as you like. I.e. prod client
 * dummy data client etc */
public protocol APIClient {

  init(configuration: APIClientConfiguration)

  var domain: URL { get }

  func getDeliveries(offset: Int, limit: Int) -> Observable<[Delivery]>
}
