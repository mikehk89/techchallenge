//
//  Delivery.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 29/11/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation

public struct Delivery {
  public let id: Int
  public let description: String
  public let imageUrl: String?
  public let location: Location?

  init?(dict: [String: Any]) {
    guard let id = dict["id"] as? Int,
      let description = dict["description"] as? String else { return nil }
    self.id = id
    self.description = description
    self.imageUrl = dict["imageUrl"] as? String

    if let locationDict = dict["location"] as? [String: Any] {
      self.location = Location(dict: locationDict)
    } else {
      self.location = nil
    }
  }
}
