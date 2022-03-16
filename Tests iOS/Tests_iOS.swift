//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Rudrank Riyam on 16/03/22.
//

import XCTest

class Tests_iOS: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testNavigation() {
        let tablesQuery = app.tables.buttons

        let abdulKalamPredicate = NSPredicate(format: "label beginswith 'A. P. J. Abdul Kalam'")
        tablesQuery.element(matching: abdulKalamPredicate).tap()
        app.navigationBars.buttons["Authors"].tap()

        let milnePredicate = NSPredicate(format: "label beginswith 'A. A. Milne'")

        tablesQuery.element(matching: milnePredicate).tap()
        app.navigationBars.buttons["Authors"].tap()
    }
}
