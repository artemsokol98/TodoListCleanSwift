//
//  Task.swift
//  TodoListCleanSwiftSokolovskiy
//
//  Created by Артем Соколовский on 22.02.2023.
//

import Foundation

class Task {
	var title: String
	var completed = false
	
	init(title: String, completed: Bool = false) {
		self.title = title
		self.completed = completed
	}
}

final class RegularTask: Task { }

final class ImportantTask: Task {
	enum TaskPriority: Int {
		case low
		case medium
		case high
	}
	
	var deadLine: Date {
		switch taskPriority {
		case .low:
			return Calendar.current.date(byAdding: .day, value: 3, to: Date())!
		case .medium:
			return Calendar.current.date(byAdding: .day, value: 2, to: Date())!
		case .high:
			return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
		}
	}
	
	var taskPriority: TaskPriority
	
	init(title: String, taskPriority: TaskPriority) {
		self.taskPriority = taskPriority
		super.init(title: title)
	}
}
