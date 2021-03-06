//
//  TimeDecisionMakerTests.swift
//  TimeDecisionMakerTests
//
//  Created by Denys Semerych on 6/12/19.
//

import XCTest
@testable import TimeDecisionMaker


class TimeDecisionMakerTests: XCTestCase {
    
    lazy var organizerFilePath: String? = Bundle.main.path(forResource: "A", ofType: "ics")
    lazy var attendeeFilePath: String? = Bundle.main.path(forResource: "B", ofType: "ics")
    
    func testVeryLongAppointment() {
        let decisionMaker = RDTimeDecisionMaker()
        guard let orgPath = organizerFilePath, let attendeePath = attendeeFilePath else {
            XCTFail("Test files should exist")
            return
        }
        XCTAssertEqual([],
                       decisionMaker.suggestAppointments(organizerICS: orgPath,
                                                         attendeeICS: attendeePath,
                                                         duration: 24 * 60 * 60, onIterval: nil))
    }
    
    // now this test failing, it should not fail
    func testAtLeastOneHourAppointmentExist() {
        let decisionMaker = RDTimeDecisionMaker()
        guard let orgPath = organizerFilePath, let attendeePath = attendeeFilePath else {
            XCTFail("Test files should exist")
            return
        }
        XCTAssertNotEqual(0,
                          decisionMaker.suggestAppointments(organizerICS: orgPath,
                                                            attendeeICS: attendeePath,
                                                            duration: 3_600, onIterval: nil).count,
                          "At least one appointment should exist")
    }
}
