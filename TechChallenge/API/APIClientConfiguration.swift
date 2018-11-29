//
//  APIClientConfiguration.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation

public protocol APIClientConfiguration {
  var endpoint: URL { get }
}

public struct ProductionConfiguration: APIClientConfiguration {
  public var endpoint: URL {
    return URL(string: "https://mock-api-mobile.dev.lalamove.com")!
  }
}

public struct DummyConfiguration: APIClientConfiguration {
  public var endpoint: URL {
    return URL(string: "todo")!
  }
}
