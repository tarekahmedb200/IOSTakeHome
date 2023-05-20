//
//  File.swift
//  IOSTakeHomeTests
//
//  Created by lapshop on 5/19/23.
//

import Foundation
@testable import IOSTakeHome


final class NetworkingManagerUserResponseSuccessMock : NetworkingManagerImpl {
    
    
    
    func request<T>(session: URLSession, endPoint: IOSTakeHome.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self) as! T
    }
    
    
    
    func request(session: URLSession, endPoint: IOSTakeHome.Endpoint) async throws {
        
    }
    
    
    
    
    
    
}
