//
//  RDTimeDecisionMaker.swift
//  TimeDecisionMaker
//
//  Created by Mikhail on 4/24/19.
//

import Foundation

class RDTimeDecisionMaker: NSObject {
    
    private func giveDateInterval(for events: [Event]) -> DateInterval {
        let minute: TimeInterval = 60
        let hour = 60 * minute
        let day = hour * 24
        let week = day * 7
        let minDate = events.sorted {$0.startDate < $1.startDate}[0].startDate
        return DateInterval(start: minDate, duration: week)
    }
    
    public func suggestAppointments(organizerICS:String, attendeeICS:String, duration:TimeInterval) -> [DateInterval] {
        let orginazerEvents = ICSDecoder.returnUserEvents(for: organizerICS)
        let attendeeEvents = ICSDecoder.returnUserEvents(for: attendeeICS)
        let dateInterval = giveDateInterval(for: orginazerEvents + attendeeEvents)
        
        print(dateInterval)
        return []
    }
}
