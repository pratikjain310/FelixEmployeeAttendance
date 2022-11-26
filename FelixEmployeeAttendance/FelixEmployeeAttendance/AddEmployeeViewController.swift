//
//  AddEmployeeViewController.swift
//  FelixEmployeeAttendance
//
//  Created by ashutosh deshpande on 18/11/2022.
//

import UIKit
import CoreData
class AddEmployeeViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePicker1: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    
    @IBOutlet weak var bloodTextField: UITextField!
    
    @IBOutlet weak var mailTextField: UITextField!
 
    var emparr : [Employee] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dateFormatter = DateFormatter()
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .date
        datePicker1.datePickerMode = .date
        dateFormatter.dateFormat = "dd/MM/yyyy"
        fetch()
        // Do any additional setup after loading the view.
    }
    func fetch(){
        do {
            emparr = try context.fetch(Employee.fetchRequest())
        }catch let error{
            print(error.localizedDescription)
        }
    }

    func savedata(emp: Employee){
        emp.name = nameTextField.text
        emp.gender = genderTextField.text
        let strDOB = dateFormatter.string(from: datePicker.date)
        emp.date_of_birth = dateFormatter.date(from: strDOB)
        
        emp.contact_number =  Int64(contactTextField.text!)!
        emp.salary = Int64(salaryTextField.text!)!
        let strJoining = dateFormatter.string(from: datePicker1.date)
        emp.date_of_joining = dateFormatter.date(from: strJoining)
        emp.mail_id = mailTextField.text
        emp.blood_group = bloodTextField.text
        emp.address = addressTextView.text
        do{
            try context.save()
        }catch let error{
            print(error.localizedDescription)
        }
        let alert = UIAlertController(title: "Alert", message: "Data Saved To Database", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { [unowned self] (action) in
            self.tabBarController?.selectedIndex = 1
            nameTextField.text = ""
            genderTextField.text = ""
            contactTextField.text = ""
            salaryTextField.text = ""
            mailTextField.text = ""
            bloodTextField.text = ""
            addressTextView.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
  
    
    @IBAction func saveButton(_ sender: Any) {
        if nameTextField.text!.isEmpty && genderTextField.text!.isEmpty && /*DOBTextField.text == "" && */ contactTextField.text!.isEmpty && salaryTextField.text!.isEmpty && /*joiningDateTextField.text == "" &&*/ mailTextField.text!.isEmpty && bloodTextField.text!.isEmpty && addressTextView.text!.isEmpty{
            let alert = UIAlertController(title: "Alert", message: "Please fill all the details", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel) { [unowned self] (action) in
                self.tabBarController?.selectedIndex = 1
            }
            alert.addAction(okAction)
            present(alert, animated: true)
            }else {
                let emp = Employee(context: context)

                     if (emparr.isEmpty == true){
                         emp.id = 1
                         
                     }else{
                         emp.id = Int64(emparr.count + 1)
                         
                     }
                savedata(emp: emp)
            }
    }

}
