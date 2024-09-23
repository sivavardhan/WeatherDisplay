//
//  CitiesSearchVCTests.swift
//  WeatherAPPTests
//
//  Created by siva reddy on 9/20/24.
//

import XCTest
import Combine
@testable import WeatherAPP // Replace with your actual module

class CitiesSearchVCTests: XCTestCase {
    
    var citiesSearchVC: CitiesSearchVC!
    var mockViewModel: MockSearchCityViewModel!
    var mockTableView: UITableView!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        citiesSearchVC = CitiesSearchVC()
        mockViewModel = MockSearchCityViewModel()
        citiesSearchVC.viewModel = mockViewModel
        cancellables = Set<AnyCancellable>()
        
        // Load the view controller's view to trigger viewDidLoad
        citiesSearchVC.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        citiesSearchVC = nil
        mockViewModel = nil
        cancellables = nil
        try super.tearDownWithError()
    }
    
    // Test that the search bar updates the view model correctly
    func testSearchBarTextDidChange() {
        citiesSearchVC.searchBar(citiesSearchVC.searchbar, textDidChange: "San Francisco")
        
        XCTAssertEqual(mockViewModel.serachedQuery, "San Francisco")
        XCTAssertFalse(citiesSearchVC.loadingIndicator.isHidden)
    }
    
    // Test that the number of rows matches the view model's searched results
    func testNumberOfRowsInSection() {
        mockViewModel.searchedResults = ResultCitiesModel(geonames: [City(name: "City 1"), City(name: "City 2")])
        
        
        let rowCount = citiesSearchVC.tableView(citiesSearchVC.resultTableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rowCount, 2)
    }
    
    // Test that the table view cell is properly configured
    func testCellForRowAt() {
        
        let cities:[City] = [City(name: "City 1"), City(name: "City 2")]
        mockViewModel.searchedResults = ResultCitiesModel(geonames: cities)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = citiesSearchVC.tableView(citiesSearchVC.resultTableView, cellForRowAt: indexPath)
        
        XCTAssertEqual(cell.textLabel?.text, "City 1")
    }
    
    // Test that selecting a row updates the city name in user defaults
    func testDidSelectRowAt() {
        mockViewModel.searchedResults = ResultCitiesModel(geonames: [City(name: "City 1")])
        
        let indexPath = IndexPath(row: 0, section: 0)
        citiesSearchVC.tableView(citiesSearchVC.resultTableView, didSelectRowAt: indexPath)
        
        XCTAssertEqual(PersistanceManager.shared.getCityName(), "City 1")
    }
    

    
    // Test that the activity indicator is added to the view
    func testActivityIndicator() {
        citiesSearchVC.addActivityIndicator()
        
        XCTAssertEqual(citiesSearchVC.loadingIndicator.superview, citiesSearchVC.view)
        XCTAssertFalse(citiesSearchVC.loadingIndicator.translatesAutoresizingMaskIntoConstraints)
    }
}

// MARK: - Mock ViewModel
class MockSearchCityViewModel: SearchCityViewModel {
    
    init() {
        super.init()
        self.searchedResults = nil
    }
}

