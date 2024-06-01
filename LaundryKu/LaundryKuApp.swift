//
//  LaundryKuApp.swift
//  LaundryKu
//
//  Created by Victor Chandra on 01/06/24.
//

import SwiftUI

@main
struct LaundryKuApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
