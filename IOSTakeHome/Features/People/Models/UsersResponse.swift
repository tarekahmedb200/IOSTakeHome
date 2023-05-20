//
//  UsersResponse.swift
//  IOSTakeHome
//
//  Created by lapshop on 5/12/23.
//

import Foundation

struct UsersResponse: Codable , Equatable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support

}
