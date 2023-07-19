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
    case popup
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
          Button {
            self.model.listItemTapped(idx)
          } label: {
            HStack {
              VStack {
                Text("Row \(idx)")
              }
              Image(systemName: "arrow.up")
              Spacer()
              VStack {
                Button("Popup") {
                  self.model.destination = .popup
                }
              }
              .buttonStyle(.borderless)
            }
            .contentShape(Rectangle())
          }
          .buttonStyle(.plain)
        }
      }
      .navigationLink(
        unwrapping: self.$model.destination,
        case: /ListModel.Destination.detail,
        destination: { $model in ContentViewC(model: model) }
      )
      .navigationTitle("List")
      .popover(unwrapping: self.$model.destination, case: /ListModel.Destination.popup) { _ in
        Button("Dismiss") {
          self.model.destination = nil
        }
      }
    }
  }
}

struct ListPreview: PreviewProvider {
  static var previews: some View {
    ListView(model: ListModel())
  }
}
