//
//  TopicListView.swift
//  TopicAndSubtopic
//
//  Created by Eric Kampman on 5/3/24.
//

import SwiftUI
import SwiftData

struct TopicListView: View {
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \Topic.index) private var topics: [Topic]
	@Binding var topicManager: TopicManager


    var body: some View {
		VStack {
			Button(action: addTopic) {
				Label("Add Topic", systemImage: "plus")
			}
			List {
				ForEach(topics) { topic in
					TopicView(topic: topic, topicManager: $topicManager)
				}
			}
		}
    }
	
	private func addTopic() {
		withAnimation {
			let newTopic = topicManager.addTopic("New Topic")
			modelContext.insert(newTopic)
		}
	}

}

#Preview {
	@State var topicManager = TopicManager(nextTopicIndex: 1)
    return TopicListView(topicManager: $topicManager)
}
