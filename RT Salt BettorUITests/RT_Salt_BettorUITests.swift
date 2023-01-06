//
//  RT_Salt_BettorUITests.swift
//  RT Salt BettorUITests
//
//  Created by Russell on 1/5/23.
//

import XCTest

final class RT_Salt_BettorUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testCanMakeRaceSelection() throws {
        let app = XCUIApplication()
        app.activate()
        
        let raceselectionviewElement = app.otherElements["RaceSelectionView"]

        let terranButton = raceselectionviewElement.images["TerranImageView"]
        XCTAssertTrue(terranButton.exists, "A Terran menu selection could not be found")
        raceselectionviewElement.images["TerranImageView"].tap()
        
        let zergButton = raceselectionviewElement.images["ZergImageView"]
        XCTAssertTrue(zergButton.exists, "A Zerg menu selection could not be found")
        raceselectionviewElement.images["ZergImageView"].tap()
        
        let protossButton = raceselectionviewElement.images["ProtossImageView"]
        XCTAssertTrue(protossButton.exists, "A Protoss menu selection could not be found")
        raceselectionviewElement.images["ProtossImageView"].tap()
        
        app.terminate()
    }
    
    func testOpenCredits() throws {
        let app = XCUIApplication()
        app.activate()
        
        let creditsButton = XCUIApplication().buttons["CreditsInformationButton"]
        XCTAssertTrue(creditsButton.exists,"The credits button could not be found in the UI")
        XCUIApplication().buttons["CreditsInformationButton"].tap()
        
        app.terminate()
    }
    
    func testTextFieldIsNotEmptyOnLaunch() throws {
        let app = XCUIApplication()
        app.activate()
        let matchEntryView = XCUIApplication().otherElements["MatchEntryView"]
        let currentMMRTextField = matchEntryView.textFields["CurrentMMRTextField"]
        let opponentMMRTextField = matchEntryView.textFields["OpponentMMRTextField"]
        
        XCTAssertTrue(currentMMRTextField.exists)
        XCTAssertTrue(opponentMMRTextField.exists)
        
        XCTAssertFalse((opponentMMRTextField.value as! String).isEmpty)
        XCTAssertFalse((opponentMMRTextField.value as! String).isEmpty)
        
        app.terminate()
    }
    
    func testTextEntryForTextField() throws {
        let app = XCUIApplication()
        app.activate()
        
        let matchEntryView = XCUIApplication().otherElements["MatchEntryView"]
        let currentMMRTextField = matchEntryView.textFields["CurrentMMRTextField"]
        let opponentMMRTextField = matchEntryView.textFields["OpponentMMRTextField"]
        
        // Starting text for both text fields is "2150"
        currentMMRTextField.tap()
        currentMMRTextField.typeText(XCUIKeyboardKey.delete.rawValue)
        currentMMRTextField.typeText("1")
        XCTAssertEqual(currentMMRTextField.value as? String, "2151")
        
        opponentMMRTextField.tap()
        opponentMMRTextField.typeText(XCUIKeyboardKey.delete.rawValue)
        opponentMMRTextField.typeText("1")
        XCTAssertEqual(opponentMMRTextField.value as? String, "2151")
        
        app.terminate()
    }

    func testDontAllowPasteOver4Characters() throws {
        let app = XCUIApplication()
        app.activate()
        
        let matchEntryView = XCUIApplication().otherElements["MatchEntryView"]
        let currentMMRTextField = matchEntryView.textFields["CurrentMMRTextField"]
        let opponentMMRTextField = matchEntryView.textFields["OpponentMMRTextField"]
        
        // Starting text for both text fields is "2150"
        currentMMRTextField.tap()
        currentMMRTextField.typeText("1")
        XCTAssertEqual(currentMMRTextField.value as? String, "2150")
        
        opponentMMRTextField.tap()
        opponentMMRTextField.typeText("1")
        XCTAssertEqual(opponentMMRTextField.value as? String, "2150")
        
        app.terminate()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
