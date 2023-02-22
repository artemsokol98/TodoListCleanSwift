//
//  LoginWorker.swift
//  TodoListCleanSwiftSokolovskiy
//
//  Created by Артем Соколовский on 22.02.2023.
//

import Foundation

public struct LoginDTO {
	var success: Int
	var login: String
	var lastLoginDate: Date
}

protocol ILoginWorker {
	func login(login: String, password: String) -> LoginDTO
}

class LoginWorker: ILoginWorker {
	func login(login: String, password: String) -> LoginDTO {
		
		if login == "Admin" && password == "pa$$32!" {
			return LoginDTO(
				success: 1,
				login: login,
				lastLoginDate: Date()
			)
		} else {
			return LoginDTO(
				success: 0,
				login: login,
				lastLoginDate: Date()
			)
		}
	}
}
