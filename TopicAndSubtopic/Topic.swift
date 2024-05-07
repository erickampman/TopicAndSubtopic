//
//  Item.swift
//  TopicSubtopic
//
//  Created by Eric Kampman on 5/3/24.
//

import Foundation
import SwiftData

@Model
final class Topic: Identifiable {
	@Attribute(.unique) var title: String
	@Relationship(deleteRule: .cascade, inverse: \Subtopic.topic)
	var subtopics = [Subtopic]()
	var index: Int
	var nextSubtopicIndex = 1

	// Add count to force the view to update
	var id: String {
		return String(index) + " " + String(subtopics.count)
	}
	
	init(title: String, index: Int) {
		self.title = title
		self.index = index
	}
	func addSubtopic(_ text: String, modelContext: ModelContext) {
		let subtopic = Subtopic(text: text, index: nextSubtopicIndex)
		nextSubtopicIndex += 1
		subtopic.topic = self
		modelContext.insert(subtopic)
	}
}

@Model
final class Subtopic: Identifiable {
	var text: String
	var topic: Topic?
	var index: Int
	
	init(text: String, index: Int) {
		self.text = text
		self.index = index
	}
}

@Observable
class TopicManager {
	var nextTopicIndex: Int
	
	init(nextTopicIndex: Int) {
		self.nextTopicIndex = nextTopicIndex
	}
	
	func addTopic(_ title: String) -> Topic {
		let topic = Topic(title: title, index: nextTopicIndex)
		nextTopicIndex += 1
		return topic
	}
	
	func addSubtopicToTopic(_ topic: Topic, text: String,modelContext: ModelContext) {
		topic.addSubtopic(text, modelContext: modelContext)
	}
	
	func setupData(modelContext: ModelContext) {
		let topic1 = addTopic("Topic 1")
//		let topic2 = addTopic("Topic 2")
		
		modelContext.insert(topic1)
//		modelContext.insert(topic2)

		topic1.addSubtopic("Subtopic 1.1", modelContext: modelContext)
//		topic1.addSubtopic("Subtopic 1.2", modelContext: modelContext)
//		
//		topic2.addSubtopic("Subtopic 2.1", modelContext: modelContext)
//		topic2.addSubtopic("Subtopic 2.2", modelContext: modelContext)
//		topic2.addSubtopic("Subtopic 2.3", modelContext: modelContext)
		
	}
}
