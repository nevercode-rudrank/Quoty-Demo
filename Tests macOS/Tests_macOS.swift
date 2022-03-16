//
//  Tests_macOS.swift
//  Tests macOS
//
//  Created by Rudrank Riyam on 16/03/22.
//

import XCTest

class Tests_macOS: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()

    }

    func testNavigation() {
        let window = XCUIApplication().windows

        let predicate = NSPredicate(format: "exists == 1")

        let abrahamQuery = window.tables.buttons["Abraham Lincoln"]

        expectation(for: predicate, evaluatedWith: abrahamQuery, handler: nil)

        waitForExpectations(timeout: 5, handler: nil)

        abrahamQuery.click()

        window.scrollViews.tables.element.swipeUp()

        let albertQuery = window.tables.buttons["Albert Einstein"]

        expectation(for: predicate, evaluatedWith: albertQuery, handler: nil)

        waitForExpectations(timeout: 5, handler: nil)

        albertQuery.click()

        window.scrollViews.tables.element.swipeDown()

        let aesopQuery = window.tables.buttons["Aesop"]

        expectation(for: predicate, evaluatedWith: aesopQuery, handler: nil)

        waitForExpectations(timeout: 5, handler: nil)

        aesopQuery.click()
    }
}
