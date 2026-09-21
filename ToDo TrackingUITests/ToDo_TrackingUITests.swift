//
//  ToDo_TrackingUITests.swift
//  ToDo TrackingUITests
//
//  Created by Jonathan Heinzman on 8/31/26.
//

import XCTest

final class ToDo_TrackingUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testSpanishLocalization() throws {
        
        let app = XCUIApplication()
        
        app.launchArguments += ["-AppleLanguages", "(es)", "-AppleLocale", "es_ES"]
        
        app.launch()
        
        // Home -> Inicio from Localizable.xcstrings
        XCTAssertTrue(app.navigationBars["Inicio"].waitForExistence(timeout: 2))

        app.buttons["profile_card_professor"].tap()
        app.buttons["add_group_button"].tap()
        
        // New group -> Nuevo grupo , Cancel -> Cancelar
        XCTAssertTrue(app.navigationBars["Nuevo grupo"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.buttons["Cancelar"].exists)
        
        // The identifier is stable across languages - same as other test
        let nameField = app.textFields["group_name_field"]
        nameField.tap()
        nameField.typeText("Ejericio")
        
        app.buttons["save_button"].tap()
        
        XCTAssertTrue(app.staticTexts["Ejericio"].waitForExistence(timeout: 2)) 
        
    }
    
}
