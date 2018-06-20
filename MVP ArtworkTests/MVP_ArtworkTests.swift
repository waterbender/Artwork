//
//  MVP_ArtworkTests.swift
//  MVP ArtworkTests
//
//  Created by Zhenia Pasko on 6/19/18.
//  Copyright © 2018 Zhenia Pasko. All rights reserved.
//

import XCTest
@testable import MVP_Artwork

class MVP_ColorsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let path = ArtworkApi.artworks(limit:10, skip:0)
        XCTAssertEqual(path.path, "get_artworks")
        
    }
}
