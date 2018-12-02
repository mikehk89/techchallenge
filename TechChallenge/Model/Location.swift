//
//  Location.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation

public struct Location {
  public let lat: Double?
  public let long: Double?
  public let address: String?

  init(dict: [String: Any]) {
    self.lat = dict["lat"] as? Double
    self.long = dict["lng"] as? Double
    self.address = dict["address"] as? String
  }
}
