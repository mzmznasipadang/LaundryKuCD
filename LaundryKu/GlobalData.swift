//
//  GlobalData.swift
//  LaundryKu
//
//  Created by Victor Chandra on 02/06/24.
//

import Foundation
import Combine

class GlobalData: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var isOnboardingCompleted: Bool = false
}
