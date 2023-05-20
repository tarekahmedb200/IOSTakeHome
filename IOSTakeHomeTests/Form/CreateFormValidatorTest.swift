//
//  CreateFormValidatorTest.swift
//  IOSTakeHomeTests
//
//  Created by lapshop on 5/19/23.
//

import XCTest
@testable import IOSTakeHome

final class CreateFormValidatorTest: XCTestCase {
  

    private var validator : CreateValidator!
    
    override func setUp() {
        validator  =  CreateValidator()
    }
    
    override func tearDown() {
        validator = nil
    }
    
    
    
    func test_with_empty_person_first_name_error_thrown () {
        let person = NewPerson()
        XCTAssertThrowsError(try validator.validate(person), "error empty first name")
        
        do {
            try validator.validate(person)
        } catch  {
            guard let valError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("wrong type of error")
                return
            }
            
            XCTAssertEqual(valError, CreateValidator.CreateValidatorError.invalidFirstName,"right error")
        }
        
    }
    
    func test_with_empty_first_name_error_thrown() {
        let person = NewPerson(lastName:"ads",job: "Ios dev")
        XCTAssertThrowsError(try validator.validate(person), "error empty first name")
    }
    
    
//    func test_with_empty_last_name_error_thrown() {
//        XCTFail()
//    }
//    
//    
//    func test_with_empty_job_error_thrown() {
//        XCTFail()
//    }
//    
//    func test_with_valid_person_error() {
//        XCTFail()
//    }
    
}




