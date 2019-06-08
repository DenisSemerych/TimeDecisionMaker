//
//  ICSDecoder.swift
//  TimeDecisionMaker 
//
//  Created by Denys Semerych on 5/31/19.
//

import Foundation
import MXLCalendarManager

class ICSDecoder {
    static let calendarManager = MXLCalendarManager()

    private static func eventsFrom(calendar: MXLCalendar?) -> [Event] {
        guard let calendar = calendar else {return []}
        var events = [Event]()
        for event in calendar.events {
            let calendarEvent = event as! MXLCalendarEvent
            let basicEvent = Event(startDate: calendarEvent.eventStartDate!, endDate: calendarEvent.eventEndDate!, uniqID:
                calendarEvent.eventUniqueID!, createdAt: calendarEvent.eventCreatedDate!, lastModified:
                calendarEvent.eventLastModifiedDate!, description: calendarEvent.eventDescription, location:
                calendarEvent.eventLocation, status: calendarEvent.eventStatus!, summary: calendarEvent.eventSummary!)
                events.append(basicEvent)
            print(basicEvent.textDescription)
        }
        return events
    }
    
    public static func returnUserEvents(for fileName: String) -> [Event] {
        var userCalendar: MXLCalendar?
        guard let path = Bundle.main.path(forResource: fileName, ofType: "ics") else {return []}
        calendarManager.scanICSFile(atLocalPath: path) { ( calendar, error) in
            guard let calendar = calendar, error == nil else {return}
            userCalendar = calendar
        }
        return eventsFrom(calendar: userCalendar).sorted(by: {$0.startDate < $1.endDate})
    }
}

//guard let calendar = calendar, error == nil else {return}
//userCalendar = calendar
