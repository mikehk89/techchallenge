//
//  APIError.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 2/12/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation

struct APIError: Error {

  init(error: Error) {
    /*TODO: Feel free to extend by using the data from the Error type to create our own error type */
  }
}

struct NoNetworkError: Error {}
struct ParsingError: Error {}
