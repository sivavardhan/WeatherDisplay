//
//  ErrorAPITest.swift
//  WeatherAPPTests
//
//  Created by siva reddy on 9/20/24.
//

import XCTest
@testable import WeatherAPP

final class ErrorAPITest: XCTestCase {

    // Test case for invalidURL
     func testInvalidURLDescription() {
         let error = APIError.invalidURL
         XCTAssertEqual(error.localizedDescription, "The URL provided was invalid.")
     }

     // Test case for networkError
     func testNetworkErrorDescription() {
         let underlyingError = NSError(domain: "TestDomain", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Network connection lost"])
         let error = APIError.networkError(underlyingError)
         XCTAssertEqual(error.localizedDescription, "A network error occurred: Network connection lost")
     }

     // Test case for invalidResponse
     func testInvalidResponseDescription() {
         let error = APIError.invalidResponse
         XCTAssertEqual(error.localizedDescription, "The server response was invalid.")
     }

     // Test case for decodingError
     func testDecodingErrorDescription() {
         let underlyingError = NSError(domain: "TestDomain", code: 1002, userInfo: [NSLocalizedDescriptionKey: "Data corrupted"])
         let error = APIError.decodingError(underlyingError)
         XCTAssertEqual(error.localizedDescription, "Failed to decode the data: Data corrupted")
     }

     // Test case for serverError
     func testServerErrorDescription() {
         let error = APIError.serverError(500)
         XCTAssertEqual(error.localizedDescription, "Server returned an error with status code 500.")
     }

     // Test case for unknownError
     func testUnknownErrorDescription() {
         let error = APIError.unknownError
         XCTAssertEqual(error.localizedDescription, "An unknown error occurred.")
     }

     // Test case for dataNotFound
     func testDataNotFoundDescription() {
         let error = APIError.dataNotFound
         XCTAssertEqual(error.localizedDescription, "Data not found (404).")
     }
}
