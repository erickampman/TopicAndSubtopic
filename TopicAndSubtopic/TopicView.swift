//
//  TopicView.swift
//  TopicAndSubtopic
//
//  Created by Eric Kampman on 5/3/24.
//

import SwiftUI


/*
 arrowtriangle.right.fill
 arrowtriangle.down.fill
 */
struct TopicView: View {
	@Environment(\.modelContext) private var modelContext
	@Bindable var topic: Topic
	@Binding var topicManager: TopicManager
	@State var showingAddTopic = false
	
    var body: some View {
		VStack(spacing: 5) {
			HStack {
				TextField("Topic Title", text: $topic.title, axis: .vertical)
					.lineLimit(2...5)
					.padding(5)
					.background(ColorMaker.textBackgroundColor)
					.cornerRadius(10)
				Button("Add Subtopic", systemImage: "plus") {
					showingAddTopic.toggle()
				}
			}
//			Text("Subtopic Count: \(topic.subtopics.count)")  // was just for debugging
			if 0 != topic.subtopics.count {
				VStack {
					ForEach(topic.subtopics) { subtopic in
						SubtopicView(subtopic: subtopic)
					}
				}
				.padding([.leading], 10)
			}
		}
		.padding(5)
		.sheet(isPresented: $showingAddTopic) {
			AddTopicView(topic: topic, topicManager: topicManager, showingAddTopic: $showingAddTopic)
		}
		.background(ColorMaker.tertiaryLabelColor)
		.cornerRadius(10)
		.overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.blue))
    }
}

struct SubtopicView: View {
	@Bindable var subtopic: Subtopic
	
	var body: some View {
		HStack {
			TextField("Subtopic Text", text: $subtopic.text, axis: .vertical)
				.lineLimit(2...5)
		}
		.frame(minWidth: 200)
		.padding([.leading], 10)
		.background(ColorMaker.textBackgroundColor)
		.cornerRadius(10)
	}
}
			
	

#Preview {
	@State var topic = Topic(title: "Topic Title", index: 1)
	@State var topicManager = TopicManager(nextTopicIndex: 1)
	return TopicView(topic: topic, topicManager: $topicManager)
}
