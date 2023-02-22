//
//  TodoListPresenter.swift
//  TodoListCleanSwiftSokolovskiy
//
//  Created by Артем Соколовский on 22.02.2023.
//

import Foundation

protocol ITodoListPresenter {
	func viewIsReady()
	var mapViewData: MainModel.ViewData! { get set }
}

class TodoListPresenter: ITodoListPresenter {
	weak var viewController: ITodoListViewController!
	var mapViewData: MainModel.ViewData!

	init(viewController: ITodoListViewController) {
		self.viewController = viewController
	}
	
	func viewIsReady() {
		viewController?.render(viewData: mapViewData)
	}
}
