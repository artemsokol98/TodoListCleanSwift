//
//  TodoListInteractor.swift
//  TodoListCleanSwiftSokolovskiy
//
//  Created by Артем Соколовский on 22.02.2023.
//

import Foundation

protocol ITodoListInteractor {
	func didTaskSelected(at indexPath: IndexPath)
}

class TodoListInteractor: ITodoListInteractor {
	private var presenter: ITodoListPresenter?
	private var worker: ITodoListWorker?
	private var sectionManager: ISectionForTaskManagerAdapter!
	
	init(worker: ITodoListWorker, presenter: ITodoListPresenter, sections: ISectionForTaskManagerAdapter) {
		self.worker = worker
		self.presenter = presenter
		self.sectionManager = sections
		pushInitialData()
	}
	
	func pushInitialData() {
		presenter?.mapViewData = worker?.mapViewData()
		presenter?.viewIsReady()
	}

	func didTaskSelected(at indexPath: IndexPath) {
		let section = sectionManager.getSection(forIndex: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.completed.toggle()
		presenter?.mapViewData = worker?.mapViewData()
		presenter?.viewIsReady()
	}
}
