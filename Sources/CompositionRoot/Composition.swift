//
//  Composition.swift
//  Composition
//
//  Created by Vid Tadel on 17/07/2023.
//

import SwiftUI
import FeatureA
import FeatureB
import ListFeature
import Models
import NavigationTools

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
    TabView {
      ContentViewA(model: mainViewModel) {
        Text("First level: \(String(describing:$0))")
      } sheetContent: { _ in
        NavigationView_Ex {
          detailB
        }
      }
      .tabItem {
        Text("A")
      }
      ListView(model: ListModel())
        .tabItem {
          Text("B")
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
