//
//  RDTimeDecisionMaker.swift
//  TimeDecisionMaker
//
//  Created by Mikhail on 4/24/19.
//

import Foundation

class RDTimeDecisionMaker: NSObject {
    
    private func giveDateIntervals(for events: [Event]) -> [DateInterval] {
        var eventsIntervals = [DateInterval]()
        guard var prevIventDateInterval = events.first?.dateInterval else {return []}
        events.forEach { event in
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
    
    private func appointments(for dateInterval: DateInterval, with duration: TimeInterval, booked: [DateInterval]) -> [DateInterval] {
        var suggestedAppointment = [DateInterval]()
        var bookedIntervals = booked
        let appointment = DateInterval(start: dateInterval.start, duration: duration)
        guard appointment.end < dateInterval.end else {return suggestedAppointment}
        if let bookedElement = bookedIntervals.first, bookedElement.intersects(appointment) {} else {suggestedAppointment.append(appointment)}
        if let bookedElement = bookedIntervals.first, bookedElement.end < appointment.end {bookedIntervals.removeFirst()}
        let leftDateInterval = DateInterval(start: appointment.end, end: dateInterval.end)
        return (suggestedAppointment + appointments(for: leftDateInterval, with: duration, booked: bookedIntervals))
    }
    
    public func suggestAppointments(organizerICS: String, attendeeICS: String, duration: TimeInterval) -> [DateInterval] {
        let orginazerEvents = ICSDecoder.returnUserEvents(for: organizerICS)
        let attendeeEvents = ICSDecoder.returnUserEvents(for: attendeeICS)
        let sortedEvents = (orginazerEvents + attendeeEvents).filter({!$0.transparent}).sorted(by: {$0.startDate < $1.startDate})
        let dateIntervals = giveDateIntervals(for: sortedEvents)
        guard let startDate = sortedEvents.first?.startDate, let endDate = sortedEvents.last?.endDate else {return []}
        let allAppointments = appointments(for: DateInterval(start: startDate, end: endDate), with: duration, booked: dateIntervals)
        return allAppointments
    }
}
