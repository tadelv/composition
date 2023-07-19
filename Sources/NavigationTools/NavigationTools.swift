//
//  NavigationTools.swift
//  
//
//  Created by Vid Tadel on 18/07/2023.
//

import Foundation
import SwiftUI
import SwiftUINavigation
@_exported import CasePaths

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
  public func navigationLink<Value, Case, Content: View>(
    unwrapping: Binding<Value?>,
    `case` casePath: CasePath<Value, Case>,
    onNavigate: @escaping (Bool) -> Void = { _ in },
    destination: @escaping (Binding<Case>) -> Content
  ) -> some View {
    self
      .background {
        if #available(iOS 16, *) {
          VStack {
            EmptyView()
          }
            .navigationDestination(
              unwrapping: unwrapping,
              case: casePath,
              destination: destination
            )
        } else {
          NavigationLink(
            unwrapping: unwrapping,
            case: casePath,
            onNavigate: onNavigate,
            destination: destination,
            label: { EmptyView() })
        }
      }
  }
}
