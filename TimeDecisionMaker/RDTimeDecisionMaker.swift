//
//  RDTimeDecisionMaker.swift
//  TimeDecisionMaker
//
//  Created by Mikhail on 4/24/19.
//

import Foundation

class RDTimeDecisionMaker: NSObject {
    
    private func giveDateInterval(for events: [Event]) -> [DateInterval] {
        var eventsIntervals = [DateInterval]()
        var prevIventDateInterval = events[0].dateInterval
        events.forEach { event in
            print(event.textDescription)
            if prevIventDateInterval.intersects(event.dateInterval) {
                if let index = eventsIntervals.firstIndex(of: prevIventDateInterval) {eventsIntervals.remove(at: index)}
                let dateInterval = DateInterval(start: event.startDate < prevIventDateInterval.start ? event.startDate : prevIventDateInterval.start , end: event.endDate > prevIventDateInterval.end ? event.endDate : prevIventDateInterval.end)
                eventsIntervals.append(dateInterval)
                prevIventDateInterval = dateInterval
            } else {
                eventsIntervals.append(event.dateInterval)
                prevIventDateInterval = event.dateInterval
            }
        }
        return eventsIntervals
    }
    
    public func suggestAppointments(organizerICS: String, attendeeICS: String, duration: TimeInterval) -> [DateInterval] {
        let orginazerEvents = ICSDecoder.returnUserEvents(for: organizerICS)
        let attendeeEvents = ICSDecoder.returnUserEvents(for: attendeeICS)
        let sortedEvents = (orginazerEvents + attendeeEvents).filter({!$0.transparent}).sorted(by: {$0.startDate < $1.endDate})
        let dateIntervals = giveDateInterval(for: sortedEvents)
        var suggestedAppointments = [DateInterval]()
        for element in dateIntervals {
            print(element.description)
        }
        return []
    }
}
