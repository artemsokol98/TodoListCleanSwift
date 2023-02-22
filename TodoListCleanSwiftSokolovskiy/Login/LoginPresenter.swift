//
//  LoginPresenter.swift
//  TodoListCleanSwiftSokolovskiy
//
//  Created by Артем Соколовский on 22.02.2023.
//

import Foundation

protocol ILoginPresenter {
	func present(responce: LoginModels.Responce)
}

class LoginPresenter: ILoginPresenter {
	private weak var viewController: ILoginViewController?
	
	init(viewController: ILoginViewController?) {
		self.viewController = viewController
	}
	
	func present(responce: LoginModels.Responce) {
		let viewModel = LoginModels.ViewModel(
			success: responce.success,
			userName: responce.login,
			lastLoginDate: "\(responce.lastLoginDate)"
		)
		
		viewController?.render(viewModel: viewModel)
	}
}
