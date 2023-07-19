import Foundation
import SwiftUI
import Images
import Fonts

public class ViewModelC: ObservableObject {
  public init() {}
}

public struct ContentViewC: View {
  @ObservedObject var model: ViewModelC
  
  public init(model: ViewModelC) {
    self.model = model
  }

  public var body: some View {
    VStack {
      Text("Welcome to FeatureC")
        .font(.app(.pacifico))
      Image(.demo)
        .resizable()
        .frame(width: 100, height: 100)
    }
  }
}

struct FeatureC_Previews: PreviewProvider {
  static var previews: some View {
    ContentViewC(model: ViewModelC())
  }
}
