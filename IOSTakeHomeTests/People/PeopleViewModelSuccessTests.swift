//
//  PeopleViewModelSuccessTests.swift
//  IOSTakeHomeTests
//
//  Created by lapshop on 5/19/23.
//

import XCTest
@testable import IOSTakeHome

final class PeopleViewModelSuccessTests: XCTestCase {
    
    
    private var networkingMock : NetworkingManagerImpl!
    private var vm : PeopleViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerUserResponseSuccessMock()
        vm = PeopleViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }
    
    func test_with_successful_response_array_is_set() async throws {
        await vm.fetchUsers()
        
        defer {
            XCTAssertFalse(vm.isLoading)
        }
        
        XCTAssertEqual(vm.users.count, 6)
    }
    
    func test_with_successful_paginated_response_users_array_is_set() async throws {
        XCTAssertFalse(vm.isLoading)
        
        await vm.fetchUsers()
        
        XCTAssertEqual(vm.users.count, 6)
        
        await vm.fetchNextSetofUsers()
        
        XCTAssertEqual(vm.users.count, 12)
        
        XCTAssertEqual(vm.page, 2)
        
    }
    
    
    
    
    
    
    
}
