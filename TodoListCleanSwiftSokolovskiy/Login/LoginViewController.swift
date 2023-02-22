//
//  LoginViewController.swift
//  TodoListCleanSwiftSokolovskiy
//
//  Created by Артем Соколовский on 22.02.2023.
//

import UIKit

protocol ILoginViewController: AnyObject {
	func render(viewModel: LoginModels.ViewModel)
}

class LoginViewController: UIViewController {
	private var interactor: ILoginInteractor?
	
	@IBOutlet weak var loginTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
		assembly()
	}
	
	@IBAction func loginButton(_ sender: UIButton) {
		if let email = loginTextField.text, let password = passwordTextField.text {
			let request = LoginModels.Request(login: email, password: password)
			interactor?.login(request: request)
		}
	}
	
	func assembly() {
		let worker = LoginWorker()
		let presenter = LoginPresenter(viewController: self)
		interactor = LoginInteractor(worker: worker, presenter: presenter)
	}
}

extension LoginViewController: ILoginViewController {
	func render(viewModel: LoginModels.ViewModel) {
				
		let alert: UIAlertController
		
		if viewModel.success {
			performSegue(withIdentifier: "SegueFromAuth", sender: nil)
		} else {
			alert = UIAlertController(
				title: "Error",
				message: "",
				preferredStyle: UIAlertController.Style.alert
			)
			let action = UIAlertAction(title: "Ok", style: .default)
			alert.addAction(action)
			present(alert, animated: true, completion: nil)
		}
	}
}
