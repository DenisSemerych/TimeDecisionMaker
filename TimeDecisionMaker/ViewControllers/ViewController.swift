//
//  ViewController.swift
//  TimeDecisionMaker
//
//  Created by Mikhail on 4/24/19.
//

import UIKit
import Hero

class ViewController: UIViewController {
    lazy var organizerFilePath: String? = Bundle.main.path(forResource: "A", ofType: "ics")
    lazy var attendeeFilePath: String? = Bundle.main.path(forResource: "B", ofType: "ics")
    let descisionMaker = RDTimeDecisionMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let orgPath = organizerFilePath, let attendeePath = attendeeFilePath else {fatalError()}
        descisionMaker.suggestAppointments(organizerICS: orgPath, attendeeICS: attendeePath, duration: 3600)
    }
}

