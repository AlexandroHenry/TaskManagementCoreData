//
//  TaskManagementCoreDataApp.swift
//  TaskManagementCoreData
//
//  Created by Seungchul Ha on 2022/12/19.
//

import SwiftUI

@main
struct TaskManagementCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
