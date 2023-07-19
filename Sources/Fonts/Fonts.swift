//
//  File.swift
//  
//
//  Created by Vid Tadel on 19/07/2023.
//

import Foundation
import SwiftUI

public enum Fonts: String, CaseIterable {
  static var autoload: Void = {
    _ = Fonts.allCases.map {
      registerFont(bundle: .module, fontName: $0.name, fontExtension: "ttf")
    }
  }()
  
  case pacifico
  
  var name: String {
    rawValue.capitalized
  }
}

extension Font {
  public static var app: (Fonts) -> Font {
    { font in
      _ = Fonts.autoload
      return .custom(font.name, size: 20, relativeTo: .body)
    }
  }
}

fileprivate func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
  guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
    fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
  }
  registerFont(from: fontURL)
}

fileprivate func registerFont(from url: URL) {
  guard let fontDataProvider = CGDataProvider(url: url as CFURL) else {
    fatalError("Could not get reference to font data provider.")
  }
  guard let font = CGFont(fontDataProvider) else {
    fatalError("Could not get font from CoreGraphics.")
  }
  var error: Unmanaged<CFError>?
  guard CTFontManagerRegisterGraphicsFont(font, &error) else {
    fatalError("Error registering font: \(dump(error)!).")
  }
}
