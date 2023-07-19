//
//  File.swift
//  
//
//  Created by Vid Tadel on 19/07/2023.
//

import Foundation
import SwiftUI

public enum Images: String {
  case demo
  
  
  public var image: Image {
    Image(rawValue, bundle: .module)
  }
}

extension Image {
  public init(_ value: Images) {
    self.init(value.rawValue, bundle: .module)
  }
}
