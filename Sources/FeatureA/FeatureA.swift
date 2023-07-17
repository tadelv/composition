import Combine
import Foundation
import Models
import SwiftUINavigation
import SwiftUI



public class ViewModelA: ObservableObject {
  
  private var cancellables = Set<AnyCancellable>()
  
  public init(destination: ViewModelA.Destination? = nil) {
    self.destination = destination
    
    $destination.sink { val in
      print("val: \(val)")
    }
    .store(in: &cancellables)
  }
  
  public enum Destination {
    case detail(DetailStateA)
    case sheet(DetailStateA)
  }
  
  @Published public var destination: Destination?
  
  func goToDetailTapped() {
    self.destination = .detail(DetailStateA())
  }
  
  func goToSheetTapped() {
    self.destination = .sheet(DetailStateA())
  }
}

public struct ContentViewA<
  DetailContent: View,
  SheetContent: View
>: View {
  public init(
    model: ViewModelA,
    @ViewBuilder detailContent: @escaping (DetailStateA) -> DetailContent,
    @ViewBuilder sheetContent: @escaping (DetailStateA) -> SheetContent
  ) {
    self.model = model
    self.detailContent = detailContent
    self.sheetContent = sheetContent
  }
  
  @ObservedObject var model: ViewModelA
  let detailContent: (DetailStateA) -> DetailContent
  let sheetContent: (DetailStateA) -> SheetContent
  
  public var body: some View {
    NavigationView {
      VStack(spacing: 50) {
        Button("Go to detail") {
          self.model.goToDetailTapped()
        }
        Button("Go to sheet") {
          self.model.goToSheetTapped()
        }
        NavigationLink(
          unwrapping: self.$model.destination,
          case: /ViewModelA.Destination.detail,
          onNavigate: { _ in }
        ) { $detailData in
          detailContent(detailData)
        } label: {
          EmptyView()
        }
      }
      .sheet(
        unwrapping: self.$model.destination,
        case: /ViewModelA.Destination.sheet
      ) { $data in
        sheetContent(data)
      }
    }
  }
}

struct FeaturePreview: PreviewProvider {
  static var previews: some View {
    ContentViewA(model: ViewModelA()) { content in
      Text("hello, \(String(describing: content))")
    } sheetContent: { content in
      Text("sheet: \(String(describing: content))")
    }
  }
}
