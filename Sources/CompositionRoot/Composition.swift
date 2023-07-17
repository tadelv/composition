//
//  Composition.swift
//  Composition
//
//  Created by Vid Tadel on 17/07/2023.
//

import FeatureA
import FeatureB
import Models
import SwiftUI

public enum Composition {
  public static var root: some Scene {
    WindowGroup {
      main
        .onOpenURL { _ in
          mainViewModel.destination = .detail(DetailStateA())
        }
    }
  }
  
  static let mainViewModel = ViewModelA()
  
  static var main: some View {
    return ContentViewA(model: mainViewModel) {
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
