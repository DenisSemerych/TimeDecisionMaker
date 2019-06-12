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
            let basicEvent = Event(startDate: event.eventStartDate!, endDate: event.eventEndDate!, uniqID:
                event.eventUniqueID!, createdAt: event.eventCreatedDate!, lastModified:
                event.eventLastModifiedDate!, description: event.eventDescription, location:
                event.eventLocation, status: event.eventStatus!, summary: event.eventSummary!, transparent: event.transp == "TRANSPARENT")
                events.append(basicEvent)
        }
        return events
    }
    
    public static func returnUserEvents(for filePath: String?) -> [Event] {
        var userCalendar: MXLCalendar?
        guard let path = filePath else {return []}
        calendarManager.scanICSFileatLocalPath(filePath: path) { ( calendar, error) in
            guard let calendar = calendar, error == nil else {return}
            userCalendar = calendar
        }
        return eventsFrom(calendar: userCalendar)
    }
}
