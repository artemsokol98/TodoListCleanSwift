//
//  TaskManager.swift
//  TodoListCleanSwiftSokolovskiy
//
//  Created by Артем Соколовский on 22.02.2023.
//

import Foundation

final class TaskManager {
	private var taskList = [Task]()
	
	public func allTasks() -> [Task] {
		taskList
	}
	
	public func completedTasks() -> [Task] {
		taskList.filter { $0.completed }
	}
	
	public func uncompletedTasks() -> [Task] {
		taskList.filter { !$0.completed }
	}
	
	public func addTask(task: Task) {
		taskList.append(task)
	}
	
	public func addTasks(tasks: [Task]) {
		taskList.append(contentsOf: tasks)
	}
	
	public func removeTask(task: Task) {
		taskList.removeAll { $0 === task }
	}
}
