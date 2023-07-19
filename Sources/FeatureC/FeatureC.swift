import Foundation
import SwiftUI

public class ViewModelC: ObservableObject {
  public init() {}
}

public struct ContentViewC: View {
  @ObservedObject var model: ViewModelC
  
  public init(model: ViewModelC) {
    self.model = model
  }

  public var body: some View {
    Text("Welcome to FeatureC")
  }
}
