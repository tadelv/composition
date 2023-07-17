//
//  Composition.swift
//  Composition
//
//  Created by Vid Tadel on 17/07/2023.
//

import FeatureA
import FeatureB
import SwiftUI

enum Composition {
  static var root: some Scene {
    WindowGroup {
      main
    }
  }
  
  static var main: some View {
    let model = ViewModelA()
    return ContentViewA(model: model) {
      Text("First level: \(String(describing:$0))")
    } sheetContent: { _ in
      NavigationView {
        detailB
      }
    }
  }
  
  static var detailB: some View {
    let model = ViewModelB()
    return ContentViewB(model: model) {
      Text("Second level: \(String(describing:$0))")
    }
  }
}
