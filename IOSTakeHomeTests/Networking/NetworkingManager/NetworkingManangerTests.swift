//
//  NetworkingManangerTests.swift
//  IOSTakeHomeTests
//
//  Created by lapshop on 5/19/23.
//

import XCTest
@testable import IOSTakeHome

final class NetworkingManangerTests: XCTestCase {
    
    private var session: URLSession!
    private var url: URL!
    
    
    override func setUp() {
        url = URL(string: "https://reqres.in/users")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSesssionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
         session = nil
         url = nil
    }
    
    
    func test_with_successful_response_response_is_valid() async throws {
            
        
        guard let path = Bundle.main.path(forResource: "UsersStaticData", ofType: "json") ,
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("failed to get file UsersStaticData")
            return
        }
        
        MockURLSesssionProtocol.loadingHandler = {
            let resposne = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            
            
            return (resposne!,data)
        }
        
        let res = try await NetworkingManager.shared.request(session: session, endPoint: .people(page: 1),type:UsersResponse.self)
        
        let staticJSON = try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        
        XCTAssertEqual(res, staticJSON)
        
    }

    
    func test_with_unsuccessful_response_code_in_invalid_range_is_invalid() async {
        
        MockURLSesssionProtocol.loadingHandler = {
            let resposne = HTTPURLResponse(url: self.url,
                                           statusCode: 400,
                                           httpVersion: nil,
                                           headerFields: nil)
            
            
            return (resposne!,nil)
        }
        
        
        do {
            _ = try await NetworkingManager.shared.request(session :session,
                                                       endPoint: .people(page: 1),
                                                       type: UsersResponse.self)
            
        } catch {
            
            
            guard let netowrkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("wrong error")
                return
            }
            
            XCTAssertEqual(netowrkingError,
                           NetworkingManager.NetworkingError.invalidStatusCode(statusCode: 400))
            
            
        }
        
        
        
        
        
        
    }
    
}
