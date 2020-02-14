//
//  Trade_Me_TaskTests.swift
//  Trade Me TaskTests
//
//  Created by Daniel Gratwicke on 12/02/20.
//  Copyright © 2020 Trade Me Recruitment. All rights reserved.
//

import XCTest
@testable import Trade_Me_Task

class Trade_Me_TaskTests: XCTestCase {
    func testTheAbilityToFormatAuthHeader() {
        let apiWrapper = TradeMeAPIWrapper()
        let expectedAuthHeader = ["Authorization": "OAuth oauth_consumer_key=\"A1AC63F0332A131A78FAC304D007E7D1\", oauth_signature_method=\"PLAINTEXT\", oauth_signature=\"EC7F18B17A062962C6930A8AE88B16C7&\""]
        
        let generatedAuthHeader = apiWrapper.prepareAuthHeader()
        
        XCTAssertEqual(generatedAuthHeader, expectedAuthHeader)
    }
}
