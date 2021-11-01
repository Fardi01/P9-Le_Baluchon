//
//  ExchangeServiceTestCase.swift
//  Le Baluchon (P.9)Tests
//
//  Created by fardi Issihaka on 18/10/2021.
//

import XCTest

@testable import Le_Baluchon__P_9_

class ExchangeServiceTestCase: XCTestCase {
    
    // MARK: - ❌ Failed: Test if callback Error
 
    func test_GetExchange_Should_Post_Failed_Callback_IfError() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: nil, response: nil, error: FakeExchangeResponseData.error))
        
        // When
        let expectation = expectation(description: "Wait for queue change")
        exchangeService.getExchange { result in
            // then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - ❌ Failed: No Datas, No Responses and No Errors
    
    func test_GetExchange_Should_Post_Failed_Callback_If_NoData() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = expectation(description: "Wait for queue change")
        exchangeService.getExchange { result in
            // then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    // MARK: - ❌ Failed: Incorrect Responses
    
    func test_GetExchange_Should_Post_Failed_Callback_If_Incorrect_Response() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: FakeExchangeResponseData.exchangeCorrectData, response: FakeExchangeResponseData.responseKO, error: nil))
        
        // When
        let expectation = expectation(description: "Wait for queue change")
        exchangeService.getExchange { result in
            // then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    // MARK: - ❌ Failed: Incorrect Datas
    
    func test_GetExchange_Should_Post_Failed_Callback_If_Incorrect_Data() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: FakeExchangeResponseData.exchangeIncorrectData, response: FakeExchangeResponseData.responseOK, error: nil))
        
        // When
        let expectation = expectation(description: "Wait for queue change")
        exchangeService.getExchange { result in
            // then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    // MARK: - ✅ Success : Correct datas and correct responses
    
    func test_GetExchange_Should_Post_Success_Callback_If_Correct_Data_And_Correct_Response() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: FakeExchangeResponseData.exchangeCorrectData, response: FakeExchangeResponseData.responseOK, error: nil))
        
        // When
        let expectation = expectation(description: "Wait for queue change")
        exchangeService.getExchange { result in
            // then
            
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
