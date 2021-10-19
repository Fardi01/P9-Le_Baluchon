//
//  ExchangeServiceTestCase.swift
//  Le Baluchon (P.9)Tests
//
//  Created by fardi Issihaka on 18/10/2021.
//

import XCTest

@testable import Le_Baluchon__P_9_

class ExchangeServiceTestCase: XCTestCase {
    
    // MARK: - ❌ Failed: Je teste que il y'a une erreur (Et que j'ai le call back d'erreur)
 
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
    
    // MARK: - ❌ Failed: Je teste le cas ou il n'ya pas de donnée, pas de reponse et pas d'erreur
    
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
    
    
    // MARK: - ❌ Failed: Je teste la cas ou je reçois une reponse incorrect
    
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
    
    
    // MARK: - ❌ Failed: Je teste le cas ou j'ai des données incorrect
    
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
    
    
    
    // MARK: - ✅ Success : Je teste le cas ou j'ai des données correct et une reponse correcte
    
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
