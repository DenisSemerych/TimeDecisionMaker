//
//  ICSDecoder.swift
//  TimeDecisionMaker 
//
//  Created by Denys Semerych on 5/31/19.
//

import Foundation
import MXLCalendarManagerSwift

class ICSDecoder {
    static let calendarManager = MXLCalendarManager()

    private static func eventsFrom(calendar: MXLCalendar?) -> [Event] {
        guard let calendar = calendar else {return []}
        var events = [Event]()
        for event in calendar.events {
            print(event.eventSummary!, event.eventStartDate!, event.eventEndDate!)
            let event = Event(startDate: event.eventStartDate!, endDate: event.eventEndDate!, uniqID: event.eventUniqueID!, createdAt: event.eventCreatedDate!, lastModified: event.eventLastModifiedDate!, description: event.eventDescription, location: event.eventLocation, status: event.eventStatus!, summary: event.eventSummary!)
            events.append(event)
            print(event.textDescription)
        }
        return events
    }
    public static func returnUserEvents(for fileName: String) -> [Event] {
        var userCalendar: MXLCalendar?
        guard let path = Bundle.main.path(forResource: fileName, ofType: "ics") else {return []}
        calendarManager.scanICSFileatLocalPath(filePath: path) { (calendar, error) in
            guard let calendar = calendar, error == nil else {return}
            userCalendar = calendar
        }
        return eventsFrom(calendar: userCalendar).sorted(by: {$0.startDate < $1.startDate})
    }
}
