//
//  TodoListViewController.swift
//  TodoListCleanSwiftSokolovskiy
//
//  Created by Артем Соколовский on 22.02.2023.
//

import UIKit

protocol ITodoListViewController: AnyObject {
	func render(viewData: MainModel.ViewData)
}

class TodoListViewController: UIViewController {
	
	var viewData: MainModel.ViewData = MainModel.ViewData(tasksBySections: [])
	private var interactor: ITodoListInteractor?
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
		tableView.delegate = self
		tableView.dataSource = self
		assembly()
	}
	
	func assembly() {
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getTasks())
		let sections = SectionForTaskManagerAdapter(taskManager: taskManager)
		// Вот тут очень спорный момент, когда пробрасываю sections и в worker и в interactor, законно ли это?
		let worker = TodoListWorker(sectionManager: sections)
		let presenter = TodoListPresenter(viewController: self)
		interactor = TodoListInteractor(worker: worker, presenter: presenter, sections: sections)
	}
}

extension TodoListViewController: UITableViewDelegate {
	
}

extension TodoListViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		viewData.tasksBySections.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewData.tasksBySections[section].title
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewData.tasksBySections[section]
		return section.tasks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let tasks = viewData.tasksBySections[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
		var contentConfiguration = cell.defaultContentConfiguration()
		
		switch taskData {
		case .importantTask(let task):
			let redText = [NSAttributedString.Key.foregroundColor:  UIColor.red]
			let taskText = NSMutableAttributedString(string: "\(task.priority) ", attributes: redText )
			taskText.append(NSAttributedString(string: task.name))
			
			contentConfiguration.attributedText = taskText
			contentConfiguration.secondaryText = task.deadLine
			contentConfiguration.secondaryTextProperties.color = task.isOverdue ? .red : .black
			cell.accessoryType = task.isDone ? .checkmark : .none
		case .regularTask(let task):
			contentConfiguration.text = task.name
			cell.accessoryType = task.isDone ? .checkmark : .none
		}
		
		cell.tintColor = .red
		contentConfiguration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		contentConfiguration.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		cell.contentConfiguration = contentConfiguration
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didTaskSelected(at: indexPath)
	}
}

extension TodoListViewController: ITodoListViewController {
	func render(viewData: MainModel.ViewData) {
		self.viewData = viewData
		tableView.reloadData()
	}
}
