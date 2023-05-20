//
//  NetworkingEndPointTests.swift
//  IOSTakeHomeTests
//
//  Created by lapshop on 5/19/23.
//

import XCTest
@testable import IOSTakeHome

final class NetworkingEndPointTests: XCTestCase {

    func test_with_people_endpoint_request_is_valid() {
            
        let peopleEndPoint = Endpoint.people(page: 1)
        
        XCTAssertEqual(peopleEndPoint.host,"reqres.in")
        XCTAssertEqual(peopleEndPoint.path,"/api/users")
    }
        
    func test_with_detail_endpoint_request_is_valid() {
        
    }
    
    func test_with_create_endpoint_request_is_valid() {
        
    }

}
