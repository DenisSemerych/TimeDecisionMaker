//
//  User.swift
//  TimeDecisionMaker
//
//  Created by Denys Semerych on 5/31/19.
//

import Foundation



class User {
    var name: String
    var timeZone: TimeZone
    var events: [Event]?
    
    init(name: String, timeZone: TimeZone, events: [Event]?) {
        self.name = name
        self.timeZone = timeZone
        self.events = events
    }
}
