//
//  APIError.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 2/12/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation

public protocol AppError {
  var uiDisplayText: String { get }
}

enum APIError: Error, AppError {
  case fetchError(Error)
  case parsing
  case unknown

  var uiDisplayText: String {
    switch self {
    case .fetchError:
      return "A server error occured"
    case .parsing:
      return "An app error occured"
    case .unknown:
      return "An unknown error occured"
    }
  }
}

struct NoNetworkError: Error, AppError {
  var uiDisplayText: String {
    return "Please reconnect to the internet"
  }
}
