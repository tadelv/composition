import Foundation
import Models
import SwiftUINavigation
import SwiftUI



public class ViewModelB: ObservableObject {
  public init(destination: ViewModelB.Destination? = nil) {
    self.destination = destination
  }
  
  public enum Destination {
    case detail(DetailStateB)
  }
  
  @Published var destination: Destination?
  
  func goToDetailTapped() {
    self.destination = .detail(DetailStateB())
  }
}

public struct ContentViewB<DetailContent: View>: View {
  public init(
    model: ViewModelB,
    detailContent: @escaping (DetailStateB) -> DetailContent
  ) {
    self.model = model
    self.detailContent = detailContent
  }
  
  @ObservedObject var model: ViewModelB
  
  let detailContent: (DetailStateB) -> DetailContent
  
  public var body: some View {
    VStack {
      Button("Go to detail B") {
        self.model.goToDetailTapped()
      }
      NavigationLink(
        unwrapping: self.$model.destination,
        case: /ViewModelB.Destination.detail,
        onNavigate: { _ in }
      ) { $data in
        self.detailContent(data)
      } label: {
        EmptyView()
      }
    }
  }
}

struct FeatureBPreview: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ContentViewB(model: ViewModelB()) { detail in
        Text("detail: \(String(describing: detail))")
      }
    }
  }
}
