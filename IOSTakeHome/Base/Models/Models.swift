//
//  Models.swift
//  IOSTakeHome
//
//  Created by lapshop on 5/12/23.
//

import Foundation

// MARK: - USER
struct User: Codable , Equatable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
}

// MARK: - Support
struct Support: Codable , Equatable {
    let url: String
    let text: String
}
