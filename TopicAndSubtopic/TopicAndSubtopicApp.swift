//
//  TopicAndSubtopicApp.swift
//  TopicAndSubtopic
//
//  Created by Eric Kampman on 5/3/24.
//

import SwiftUI
import SwiftData

@main
struct TopicAndSubtopicApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Topic.self,
			Subtopic.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
