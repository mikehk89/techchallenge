//
//  APIError.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 2/12/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation

enum APIError: Error {
  case fetchError(Error)
  case parsing
  case unknown
}

struct NoNetworkError: Error {}
struct ParsingError: Error {}
