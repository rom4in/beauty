//
//  Buttons.swift
//  beauty
//
//  Created by Ubicolor on 07/12/2021.
//

import SwiftUI

struct PhotoShareButtonStyle : ButtonStyle {

  func makeBody(configuration: Configuration) -> some View {

      ZStack {
          Circle().background(.ultraThinMaterial).frame(width: 44, height: 44)
          configuration.label.foregroundColor(Color(.systemBackground))
      }
          .scaleEffect(configuration.isPressed ? 0.95 : 1)
          .shadow(radius: 5)
  }
}
