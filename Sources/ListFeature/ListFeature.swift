//
//  ListFeature.swift
//  
//
//  Created by Vid Tadel on 19/07/2023.
//

import Foundation
import SwiftUI
import NavigationTools
import FeatureC

public class ListModel: ObservableObject {
  public enum Destination {
    case detail(ViewModelC)
  }
  
  @Published public var destination: Destination?
  
  public init(destination: ListModel.Destination? = nil) {
    self.destination = destination
  }
  
  func listItemTapped(_ index: Int) {
    self.destination = .detail(ViewModelC())
  }
}

public struct ListView: View {
  @ObservedObject var model: ListModel
  
  public init(model: ListModel) {
    self.model = model
  }
  
  public var body: some View {
    NavigationView_Ex {
      List {
        ForEach(0...10, id: \.self) { idx in
          HStack {
            VStack {
              Text("Row \(idx)")
            }
            Image(systemName: "arrow.up")
            Spacer()
          }
          .contentShape(Rectangle())
          .onTapGesture {
            self.model.listItemTapped(idx)
          }
        }
      }
      .navigationLink(
        unwrapping: self.$model.destination,
        case: /ListModel.Destination.detail,
        destination: { $model in ContentViewC(model: model) }
      )
      .navigationTitle("List")
    }
  }
}

struct ListPreview: PreviewProvider {
  static var previews: some View {
    ListView(model: ListModel())
  }
}
