//
//  ViewController.swift
//  TimeDecisionMaker
//
//  Created by Mikhail on 4/24/19.
//

import UIKit

class ViewController: UIViewController {

    let descisionMaker = RDTimeDecisionMaker()
    override func viewDidLoad() {
        super.viewDidLoad()
        descisionMaker.suggestAppointments(organizerICS: "A", attendeeICS: "B", duration: 3600)
    }
}

