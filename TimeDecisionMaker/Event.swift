//
//  Event.swift
//  TimeDecisionMaker
//
//  Created by Denys Semerych on 5/31/19.
//

import Foundation


struct Event {
    
    var startDate: Date
    var endDate: Date
    var dateInterval: DateInterval {
        return DateInterval(start: startDate, end: endDate)
    }
    var uniqID: String
    var createdAt: Date
    var lastModified: Date
    var description: String?
    var location: String?
    var status: String
    var summary: String
    var textDescription: String {
        return "An event on start date - \(startDate), ends - \(endDate). Event Summary: \(summary)"
    }
}


extension Event: Hashable {
    static func ==(lhs: Event, rsh: Event) -> Bool {
        return lhs.dateInterval.intersects(rsh.dateInterval)
    }
}
