//
//  AddTopicView.swift
//  TopicAndSubtopic
//
//  Created by Eric Kampman on 5/4/24.
//

import SwiftUI

struct AddTopicView: View {
	@Environment(\.modelContext) private var modelContext
	@Bindable var topic: Topic
	var topicManager: TopicManager
	@Binding var showingAddTopic: Bool
	@State private var text = ""

    var body: some View {
		VStack {
			TextField("Subtopic Text", text: $text, axis: .vertical)
				.lineLimit(2...5)
			HStack {
				Button("Add") {
					topicManager.addSubtopicToTopic(topic, text: text, modelContext: modelContext)
					showingAddTopic = false
				}
				Button("Cancel") {
					showingAddTopic = false
				}
			}
		}
		.padding()
    }
}

#Preview {
	@State var topic = Topic(title: "Foobar", index: 1)
	@State var showingAddTopic = false
	@State var topicManager = TopicManager(nextTopicIndex: 1)
    return AddTopicView(topic: topic, topicManager: topicManager, showingAddTopic: $showingAddTopic)
}
