//
//  NavigationTools.swift
//  
//
//  Created by Vid Tadel on 18/07/2023.
//

import Foundation
import SwiftUI
import SwiftUINavigation

public struct NavigationView_Ex<Content: View>: View {
  
  let content: () -> Content
  
  public init(
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = content
  }
  
  public var body: some View {
    if #available(iOS 16, *) {
      NavigationStack(root: content)
    } else {
      NavigationView(content: content)
    }
  }
}

extension View {
  public func navigationDestination() -> some View {
    self
  }
}
