//
//  Fetch_iOSChallengeUITests.swift
//  Fetch-iOSChallengeUITests
//
//  Created by JaredMurray on 8/1/24.
//

import XCTest

final class Fetch_iOSChallengeUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    //This test was used on a previous ui build/no longer needed
//    func testExample() throws {
//        let app = XCUIApplication()
//        app.launch()
//
//        //sometimes the VStack that contains the ingredients and measurements dissappears
//        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Apple Frangipan Tart"]/*[[".cells",".buttons[\"Apple Frangipan Tart, 52768\"].staticTexts[\"Apple Frangipan Tart\"]",".staticTexts[\"Apple Frangipan Tart\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//        XCTAssertTrue(app.staticTexts["ingredientStack"].exists)    //hasn't failed through numerous test attempts
//    }
}
