//
//  EmployeeDetailViewController.swift
//  FelixEmployeeAttendance
//
//  Created by ashutosh deshpande on 18/11/2022.
//

import UIKit
import CoreData
class EmployeeDetailViewController: UIViewController {
    var employeeData : Employee?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var bloodTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var joiningDateTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var DOBTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        checkButton.setImage(UIImage(systemName: "seal"), for: .normal)
        // Do any additional setup after loading the view.
        fetch()
    }
    func fetch(){
        nameTextField.text = employeeData?.name
        genderTextField.text = employeeData?.gender
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        DOBTextField.text = dateFormatter.string(for: employeeData!.date_of_birth)
        contactTextField.text = String(employeeData!.contact_number)
        salaryTextField.text = String(employeeData!.salary)
        joiningDateTextField.text = dateFormatter.string(for: employeeData!.date_of_joining)
        mailTextField.text = employeeData?.mail_id
        bloodTextField.text = employeeData?.blood_group
        addressTextView.text = employeeData?.address
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkButton(_ sender: Any) {
        if checkButton.currentImage == UIImage(systemName: "seal"){
        
        checkButton.setImage(UIImage(systemName: "checkmark.seal"), for: .normal)
        editButton.isHidden = false
            // all textfield is enable code
            nameTextField.isEnabled = true
            genderTextField.isEnabled = true
            DOBTextField.isEnabled = true
            contactTextField.isEnabled = true
            salaryTextField.isEnabled = true
            joiningDateTextField.isEnabled = true
            mailTextField.isEnabled = true
            bloodTextField.isEnabled = true
            addressTextView.isEditable = true
            addressTextView.isSelectable = true
        }else {
            checkButton.setImage(UIImage(systemName: "seal"), for: .normal)
            editButton.isHidden = true
            nameTextField.isEnabled = false
            genderTextField.isEnabled = false
            DOBTextField.isEnabled = false
            contactTextField.isEnabled = false
            salaryTextField.isEnabled = false
            joiningDateTextField.isEnabled = false
            mailTextField.isEnabled = false
            bloodTextField.isEnabled = false
            addressTextView.isEditable = false
            addressTextView.isSelectable = false
            // all textfield is disable code
        }
    }
   
    @IBAction func editButton(_ sender: Any) {
        if nameTextField.text == "" && genderTextField.text == "" && DOBTextField.text == "" && contactTextField.text == "" && salaryTextField.text == "" && joiningDateTextField.text == "" && mailTextField.text == "" && bloodTextField.text == "" && addressTextView.text == ""{
            let alert = UIAlertController(title: "Alert", message: "Please fill all the details", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel) { [unowned self] (action) in
                self.tabBarController?.selectedIndex = 1
            }
            alert.addAction(okAction)
            present(alert, animated: true)
        }else {
            employeeData?.name = nameTextField.text
            employeeData?.gender = genderTextField.text
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dobDate = dateFormatter.date(from: DOBTextField.text!)
            employeeData?.date_of_birth = dobDate
            employeeData?.contact_number = Int64(contactTextField.text!)!
            employeeData?.salary = Int64(salaryTextField.text!)!
            let joiningDate = dateFormatter.date(from: joiningDateTextField.text!)
            employeeData?.date_of_joining = joiningDate
            employeeData?.mail_id = mailTextField.text
            employeeData?.blood_group = bloodTextField.text
            employeeData?.address = addressTextView.text
            try? context.save()
            navigationController?.popViewController(animated: true)
        }
    }
    
}
