//
//  Composition.swift
//  Composition
//
//  Created by Vid Tadel on 17/07/2023.
//

import SwiftUI
import FeatureA
import FeatureB
import FeatureC
import ListFeature
import Models
import NavigationTools

enum Tab: Int {
  case tabA
  case tabB
}

public enum Composition {
  public static var root: some Scene {
    WindowGroup {
      main
        .onOpenURL { _ in
//          viewModelA.destination = .detail(DetailStateA())
          mainViewModel.tab = .tabB
          listModel.destination = .detail(ViewModelC())
        }
    }
  }
  
  static let mainViewModel = MainViewModel()
  static let viewModelA = ViewModelA()
  static let listModel = ListModel()
  
  static var main: some View {
    MainView(
      model: mainViewModel,
      viewModelA: viewModelA,
      listModel: listModel
    )
  }
  
  
}

class MainViewModel: ObservableObject {
  @Published var tab: Tab = .tabA
}

struct MainView: View {
  @ObservedObject var model: MainViewModel
  let viewModelA: ViewModelA
  let listModel: ListModel
  
  var body: some View {
    TabView(selection: self.$model.tab) {
      ContentViewA(model: viewModelA) {
        Text("First level: \(String(describing:$0))")
      } sheetContent: { _ in
        NavigationView_Ex {
          detailB
        }
      }
      .tabItem {
        Label("FeatureA", systemImage: "arrow.left")
      }
      .tag(Tab.tabA)
      ListView(model: listModel)
        .tabItem {
          Label("List", systemImage: "arrow.right")
        }
        .tag(Tab.tabB)
    }
  }
  
  var detailB: some View {
    let model = ViewModelB()
    return ContentViewB(model: model) {
      Text("Second level: \(String(describing:$0))")
    }
  }
}
