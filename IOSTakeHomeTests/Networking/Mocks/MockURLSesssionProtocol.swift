//
//  MockURLSesssionProtocol.swift
//  IOSTakeHomeTests
//
//  Created by lapshop on 5/19/23.
//

import Foundation
import XCTest

class MockURLSesssionProtocol : URLProtocol {
    
    static var loadingHandler : (() -> (HTTPURLResponse,Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        guard let handler = MockURLSesssionProtocol.loadingHandler else {
            XCTFail("loadingHandler is not set")
            return
        }
        
        let (response , data) = handler()
        
        client?.urlProtocol(self, didReceive: response,cacheStoragePolicy: .notAllowed)
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    
    override func stopLoading() {
        
    }
    
}
