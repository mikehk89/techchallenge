//
//  EnvironmentManager.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation

public func dataLoader() -> APIClient {
  return EnvironmentManager.current.client
}

/* Handles API / Data environment (prod, staging etc) */
public class EnvironmentManager {

  public static private(set) var current = EnvironmentManager(configuration: ProductionConfiguration())

  public private(set) var client: APIClient

  private init(configuration: APIClientConfiguration) {
    client = DeliveryCompanyClient(configuration: configuration)
  }
}
