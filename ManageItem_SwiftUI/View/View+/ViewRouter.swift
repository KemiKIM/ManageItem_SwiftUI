//
//  ViewRouter.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import SwiftUI

class ViewRouter: ObservableObject {
    @Published var path = NavigationPath()

      func reset() {
          path.removeLast(path.count)
      }

      func navigate(to screen: Screen) {
          path.append(screen)
      }
}
