//
//  TimeDecisionMakerTests.swift
//  TimeDecisionMakerTests
//
//  Created by Denys Semerych on 6/12/19.
//

import XCTest
@testable import TimeDecisionMaker


class TimeDecisionMakerTests: XCTestCase {
    
    
    //this test part was changed by me because of icapsulating file opening in ICSDecored insted of TimeDescitionMaker
    //It is only needs file name and ICS decored does the rest
    lazy var organizerFilePath: String? = "A"
    lazy var attendeeFilePath: String? = "B"
    
    func testVeryLongAppointment() {
        let decisionMaker = RDTimeDecisionMaker()
        guard let orgPath = organizerFilePath, let attendeePath = attendeeFilePath else {
            XCTFail("Test files should exist")
            return
        }
        XCTAssertEqual([],
                       decisionMaker.suggestAppointments(organizerICS: orgPath,
                                                         attendeeICS: attendeePath,
                                                         duration: 24 * 60 * 60))
    }
    
    // now this test failing, it should not fail
    func testAtLeastOneHourAppointmentExist() {
        let decisionMaker = RDTimeDecisionMaker()
        guard let orgPath = organizerFilePath, let attendeePath = attendeeFilePath else {
            XCTFail("Test files should exist")
            return
        }
        print(decisionMaker.suggestAppointments(organizerICS: orgPath,
                                                attendeeICS: attendeePath,
                                                duration: 3_600).count)
        XCTAssertNotEqual(0,
                          decisionMaker.suggestAppointments(organizerICS: orgPath,
                                                            attendeeICS: attendeePath,
                                                            duration: 3_600).count,
                          "At least one appointment should exist")
    }
}
