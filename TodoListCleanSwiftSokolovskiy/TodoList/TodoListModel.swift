//
//  TodoListModel.swift
//  TodoListCleanSwiftSokolovskiy
//
//  Created by Артем Соколовский on 22.02.2023.
//

import Foundation

enum MainModel {
	struct ViewData {
		struct RegularTask {
			let name: String
			let isDone: Bool
		}
		
		struct ImportantTask {
			let name: String
			let isDone: Bool
			let isOverdue: Bool
			let deadLine: String
			let priority: String
		}
		
		enum Task {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}
		
		struct Section {
			let title: String
			let tasks: [Task]
		}
		
		let tasksBySections: [Section]
	}
}
