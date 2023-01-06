//
//  RT_Salt_BettorTests.swift
//  RT Salt BettorTests
//
//  Created by Russell on 1/5/23.
//

import XCTest
@testable import RT_Salt_Bettor

final class RT_Salt_BettorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: BWMatch
    func testMMRProperties() throws {
        let match = BWMatch(currentMMR: 2000, opponentMMR: 2200, opponentRace: .Terran)
        XCTAssertEqual(match.currentMMR, 2000)
        XCTAssertEqual(match.opponentMMR, 2200)
    }
    
    func testOpponentRace() throws {
        let match = BWMatch(currentMMR: 2000, opponentMMR: 2200, opponentRace: .Terran)
        XCTAssertEqual(match.opponentRace, .Terran)
    }
    
    func testSetOpponentRace() throws {
        var match = BWMatch(currentMMR: 2000, opponentMMR: 2200, opponentRace: .Terran)
        match.opponentRace = .Protoss
        XCTAssertEqual(match.opponentRace, .Protoss)
    }
    
    // MARK: Color Text
    func testTextColorForZeroMMR() throws {
        let mev = MatchEntryView()
        let color = mev.textColor(for: 0)
        XCTAssertEqual(color, UIColor(red: 184/255, green: 183/255, blue: 183/255, alpha: 1))
    }
    
    func testTextColorForMMR1175() throws {
        let mev = MatchEntryView()
        let color = mev.textColor(for: 1175)
        XCTAssertEqual(color, UIColor(red: 184/255, green: 183/255, blue: 183/255, alpha: 1))
    }
    
    func testTextColorForMMR1176() throws {
        let mev = MatchEntryView()
        let color = mev.textColor(for: 1176)
        XCTAssertEqual(color, UIColor(red: 75/255, green: 210/255, blue: 118/255, alpha: 1))
    }
    
    func testTextColorForMMR2139() throws {
        let mev = MatchEntryView()
        let color = mev.textColor(for: 2139)
        XCTAssertEqual(color, UIColor(red: 220/255, green: 200/255, blue: 80/255, alpha: 1))
    }
    
    func testTextColorForMaxMMR() throws {
        let mev = MatchEntryView()
        let color = mev.textColor(for: Int.max)
        XCTAssertEqual(color, UIColor(red: 220/255, green: 200/255, blue: 80/255, alpha: 1))
    }
    
    // MARK: 4 Character entry only, TextFieldDelegate
    func testDeletingCharacters() throws {
        let mev = MatchEntryView()
        let tf = mev.currentMMR
        tf.text = "1234"
        let result = mev.textField(tf, shouldChangeCharactersIn: NSRange(location: 4, length: 0), replacementString: "")
        XCTAssertTrue(result)
    }
    
    func testBlockingInputOver4Characters() {
        let mev = MatchEntryView()
        let tf = mev.currentMMR
        tf.text = "123"
        let result = mev.textField(tf, shouldChangeCharactersIn: NSRange(location: 3, length: 0), replacementString: "45")
        print(result)
        print(tf.text)
        XCTAssertFalse(result)
    }
    
    func testAllowingInputOf4Characters() {
        let mev = MatchEntryView()
        let tf = mev.currentMMR
        tf.text = "123"
        let result = mev.textField(tf, shouldChangeCharactersIn: NSRange(location: 3, length: 0), replacementString: "4")
        XCTAssertTrue(result)
    }
    
    func testBlockingInputOver5Characters() {
        let mev = MatchEntryView()
        let tf = mev.currentMMR
        tf.text = "1234"
        let result = mev.textField(tf, shouldChangeCharactersIn: NSRange(location: 4, length: 0), replacementString: "5")
        XCTAssertFalse(result)
    }


}
