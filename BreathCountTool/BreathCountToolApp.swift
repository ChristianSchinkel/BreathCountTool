//
//  BreathCountToolApp.swift
//  BreathCountTool
//
//  Created by Christian Schinkel on 2024-09-03.
//

import SwiftUI
import SwiftData

@main
struct BreathCountToolApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RespiratoryRateCountView()
        }
        .modelContainer(sharedModelContainer)
    }
}
