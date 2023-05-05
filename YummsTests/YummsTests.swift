//
//  YummsTests.swift
//  YummsTests
//
//  Created by Josfry Barillas on 4/28/23.
//

import XCTest
@testable import Yumms

final class YummsTests: XCTestCase {
    var networkModel = DessertAPI()
    var networkManager = NetworkManager()
    var dessertVC = DessertViewController()
    let testURL = URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
    var expectedDessert = Dessert(strMeal: "", strMealThumb: URL(string: ""), idMeal: "")

    func testDessertURL() throws {
        guard let unwrappedURL = DessertAPI.dessertsURL else { return }
        
        let expectedURL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
        //let currentURL = try XCTUnwrap(String(DessertAPI.dessertsURL))
        XCTAssertEqual(expectedURL, unwrappedURL)
    }
    
    func testDessertDetailsURL()  {
        guard let unwrappedURL = DessertAPI.dessertDetailsURL else { return }
        
        let expectedURL = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=")
        //let currentURL = try XCTUnwrap(String(DessertAPI.dessertsURL))
        XCTAssertEqual(expectedURL, unwrappedURL)
    }
    

    func testCorrectData() {
        let firstDessert = Dessert(strMeal: "Apam balik", strMealThumb: (URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")!), idMeal: "53049")
        
       // let expectedFirstDessert = dessertVC.dessertList[0]
        networkManager.fetchDesserts { [self] dessert in
            switch dessert {
            case let .success(desserts):
                expectedDessert = desserts[0]
            XCTAssertEqual(firstDessert, expectedDessert)
            case .failure(_):
                print("error")
            }
            
        }
    }


}
