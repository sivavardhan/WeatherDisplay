//
//  AppCoordinatorTests.swift
//  WeatherAPPTests
//
//  Created by siva reddy on 9/20/24.
//

import XCTest
@testable import WeatherAPP

final class AppCoordinatorTests: XCTestCase {

    var appCoordinator: AppCoordinator!
    var mockNavController: MockNavigationController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNavController = MockNavigationController()
        appCoordinator = AppCoordinator(navController: mockNavController)
    }

    override func tearDownWithError() throws {
        appCoordinator = nil
        mockNavController = nil
        try super.tearDownWithError()
    }
    
    // Test that the AppCoordinator initializes with the correct navigation controller
    func testInitWithNavigationController() {
        XCTAssertEqual(appCoordinator.navigationController, mockNavController)
    }
    
    // Test that the start method calls showWeatherScreen
    func testStartCallsShowWeatherScreen() {
        appCoordinator.start()
        
        XCTAssertEqual(mockNavController.pushedViewController is WeatherViewController, true)
    }
    
    // Test that the WeatherViewController is pushed onto the navigation stack
    func testShowWeatherScreenPushesWeatherVC() {
        appCoordinator.showWeatherScreen()
        
        let pushedVC = mockNavController.pushedViewController as? WeatherViewController
        XCTAssertNotNil(pushedVC)
        XCTAssertNotNil(pushedVC?.viewModel)
    }
    
    // Test that starting the city search coordinator adds it as a child
    func testStartCitySearchCoordinatorAddsChild() {
        appCoordinator.startCitySearchCoordinator()
        
        XCTAssertEqual(appCoordinator.childCoordinators.count, 1)
        XCTAssertTrue(appCoordinator.childCoordinators.first is CitySearchCoordinator)
    }
    
    // Test that city search completion removes the child coordinator
    func testCitySearchCompletionRemovesChildCoordinator() {
        appCoordinator.startCitySearchCoordinator()
        
        let citySearchCoordinator = appCoordinator.childCoordinators.first as? CitySearchCoordinator
        citySearchCoordinator?.onCitySelected?() // Simulate city selection
        
        XCTAssertEqual(appCoordinator.childCoordinators.count, 0)
    }
    
    // Test that the onCitySearchTapped closure triggers the start of the city search coordinator
    func testWeatherVCOnCitySearchTappedTriggersCitySearchCoordinator() {
        appCoordinator.showWeatherScreen()
        
        let weatherVC = mockNavController.pushedViewController as? WeatherViewController
        XCTAssertNotNil(weatherVC)
        
        weatherVC?.onCitySearchTapped?() // Simulate the city search button tapped
        
        XCTAssertEqual(appCoordinator.childCoordinators.count, 1)
    }
    

}
class MockNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    // Mock Pop to View Controller (if needed)
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
}
