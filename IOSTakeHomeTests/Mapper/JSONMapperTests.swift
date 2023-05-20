//
//  JSONMapperTests.swift
//  IOSTakeHomeTests
//
//  Created by lapshop on 5/19/23.
//

import Foundation
import XCTest
@testable import IOSTakeHome


class JSONMapperTests : XCTestCase {
    
    func test_with_valid_json_successfully_decodes() {
        XCTAssertNoThrow(try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self),"Mapper not throws")
        
        
        let userResponse = try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        XCTAssertNotNil(userResponse,"user response should not be nil")
        
        XCTAssertEqual(userResponse?.page , 1, "page" )
        XCTAssertEqual(userResponse?.perPage , 6 , "perPage")
        XCTAssertEqual(userResponse?.total , 12 , "total")
        XCTAssertEqual(userResponse?.totalPages , 2, "totalPages")
    }
    
    func test_with_missing_file_error_thrown() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: UsersResponse.self), "wrong file")
        
        do {
            _ = try StaticJSONMapper.decode(file: "", type: UsersResponse.self)
        }catch {
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("wrong type of error")
                return
            }
            XCTAssertEqual(mappingError,StaticJSONMapper.MappingError.failedToGetContents,"right error")
        }
        
    }
    
    func test_with_invalid_json_error_thrown() {
        
    }
    
    
}


