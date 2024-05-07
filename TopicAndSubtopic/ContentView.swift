//
//  ContentView.swift
//  TopicAndSubtopic
//
//  Created by Eric Kampman on 5/3/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
	@Query private var topics: [Topic]
	@State private var topicManager = TopicManager(nextTopicIndex: 1)

    var body: some View {
        NavigationSplitView {
			VStack {
				NavigationLink("Topics", value: topics)
					.navigationDestination(for: [Topic].self) { _ in
						TopicListView(topicManager: $topicManager)
					}
				NavigationLink("Somewhere Else", value: "somewhere else")
					.navigationDestination(for: String.self) { _ in
						SomewhereElseView()
					}
			}
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
				ToolbarItem {
					Button(action: addTopic) {
						Label("Add Topic", systemImage: "plus")
					}
				}
            }
        } detail: {
			Text("Select a topic")
        }
		.onAppear {
			if topics.count == 0 {
				topicManager.nextTopicIndex = topics.count + 1
				topicManager.setupData(modelContext: modelContext)
			}
		}
    }
	
	private func addTopic() {
		withAnimation {
			let newTopic = topicManager.addTopic("New Topic")
			modelContext.insert(newTopic)
		}
	}

	private func deleteTopics(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(topics[index])
			}
		}
	}
}

#Preview {
	ContentView()
        .modelContainer(for: Topic.self, inMemory: true)
}
