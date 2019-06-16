//
//  ViewController.swift
//  TimeDecisionMaker
//
//  Created by Mikhail on 4/24/19.
//

import UIKit

class ViewController: UIViewController {

    let descisionMaker = RDTimeDecisionMaker()
    var suggestedDateIntervals = [DateInterval]() {
        didSet {
            suggestedDateIntervalTable.reloadData()
            suggestedDateIntervalTable.isHidden = false
        }
    }
    var users = [String]()
    var userFieldToEdit: UITextField?
    var dateFieldToEdit: DateTextField?
    
    @IBOutlet weak var firstUserTextField: UITextField!
    @IBOutlet weak var secondUserTextField: UITextField!
    @IBOutlet weak var dateFrom: DateTextField!
    @IBOutlet weak var dateTo: DateTextField!
    @IBOutlet weak var appointmentDuration: UITextField!
    @IBOutlet weak var suggestedDateIntervalTable: UITableView!
    @IBAction func submit(_ sender: UIButton) {
        let splittedFirstICS = firstUserTextField.text?.components(separatedBy: ".")
        let splittedSecondICS = secondUserTextField.text?.components(separatedBy: ".")
        guard let firstICSElements = splittedSecondICS, let secondICSElements = splittedFirstICS, firstICSElements.count == 2,  secondICSElements.count == 2, let duration = TimeInterval(appointmentDuration.text!), let firstDate = dateFrom.date, let secondDate = dateTo.date, let firstFilePath = Bundle.main.path(forResource: firstICSElements[0], ofType: "ics"), let secondFilePath = Bundle.main.path(forResource: secondICSElements[0], ofType: "ics"), firstDate < secondDate, duration > 0 else {return}
        let dateInterval = DateInterval(start: firstDate, end: secondDate)
        suggestedDateIntervals = descisionMaker.suggestAppointments(organizerICS: firstFilePath, attendeeICS: secondFilePath, duration: duration, onIterval: dateInterval)
        print(suggestedDateIntervals)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        suggestedDateIntervalTable.delegate = self
        suggestedDateIntervalTable.dataSource = self
        suggestedDateIntervalTable.isHidden = true
        dateFrom.delegate = self
        dateTo.delegate = self
        firstUserTextField.delegate = self
        secondUserTextField.delegate = self
        appointmentDuration.delegate = self
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestedDateIntervals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateIntervalCell")
        cell!.textLabel?.text = "Avalible interval from \(suggestedDateIntervals[indexPath.row].start) to \(suggestedDateIntervals[indexPath.row].end)"
        return cell!
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.placeholder == "Choose User" {
            userFieldToEdit = textField
            users = getUserNames()
            presentUserPicker()
        } else if textField.placeholder == "Appointment duration" {
            return true
        } else if textField.placeholder?.contains("date") ?? false {
            dateFieldToEdit = textField as? DateTextField
            presentDatePicker()
        }
        return false
    }
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userFieldToEdit?.text = users[row]
        view.viewWithTag(7)?.removeFromSuperview()
    }
    
    func presentUserPicker() {
        guard view.viewWithTag(7) == nil else {return}
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.tag = 7
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func presentDatePicker() {
        guard  view.viewWithTag(8) == nil else {return}
        let datePicker = UIDatePicker()
        datePicker.calendar = Calendar.current
        datePicker.datePickerMode = .dateAndTime
        datePicker.tag = 8
        datePicker.maximumDate = datePicker.minimumDate?.addingTimeInterval(60 * 60 * 24 * 31)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        appointmentDuration.resignFirstResponder()
        view.viewWithTag(7)?.removeFromSuperview()
        if let datePicker = view.viewWithTag(8) as? UIDatePicker {
            dateFieldToEdit?.text = datePicker.date.description(with: Locale.current)
            dateFieldToEdit?.date = datePicker.date
            datePicker.removeFromSuperview()
        }
    }
}


extension ViewController {
    func getUserNames() -> [String] {
        let path = Bundle.main.resourcePath!
        var items = [String]()
        do {
            items = try FileManager.default.contentsOfDirectory(atPath: path)
        } catch {}
        return items.filter({$0.contains(".ics")})
    }
}


