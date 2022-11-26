//
//  HomeScreenViewController.swift
//  FelixEmployeeAttendance
//
//  Created by ashutosh deshpande on 18/11/2022.
//

import UIKit
import CoreData
class HomeScreenViewController: UIViewController {
    @IBOutlet weak var employeeTableView: UITableView!
    var emparr : [Employee] = []
    var attenarr : [Attendance] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    var flag = 1
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        fetch()
        fetch1()
    }
    func fetch(){
        do {
            emparr = try context.fetch(Employee.fetchRequest())
            DispatchQueue.main.async {
                self.employeeTableView.reloadData()
            }
        }catch let error{
            print(error.localizedDescription)
        }
    }
    func fetch1(){
        do {
            attenarr = try context.fetch(Attendance.fetchRequest())
//            DispatchQueue.main.async {
//                self.employeeTableView.reloadData()
//            }
        }catch let error{
            print(error.localizedDescription)
        }
    }
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emparr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emp = emparr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = emp.name
        return cell!
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let emp = emparr[indexPath.row]
        let ca = UIContextualAction(style: .destructive, title: "Delete") { [unowned self](action, view, nil) in
        
            let a = UIAlertController(title: "Delete", message: "Do you want to Delete?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [unowned self] (action) in
                self.context.delete(emp)
                do {
                    try context.save()
                    fetch()
                }catch let error {
                    print(error.localizedDescription)
                }
                
            }
            let noAction = UIAlertAction(title: "No", style: .cancel) { (action) in
            }
            a.addAction(yesAction)
            a.addAction(noAction)
            self.present(a, animated: true)
            
        }
        
        return UISwipeActionsConfiguration(actions: [ca])
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if flag == 0{
        let ca = UIContextualAction(style: .normal, title: "Present") { [unowned self] (action, view, nil) in
//            let atten = attenarr[indexPath.row]
//            let emp = emparr[indexPath.row]
//            if attenarr.isEmpty {
//                atten.attendance_Id = 1
//            }else {
//                atten.attendance_Id = Int64(attenarr.count + 1)
//            }
//            atten.id = emp.id
//            atten.name = emp.name
//            let todaysDate = NSDate()
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd/MM/yyyy"
//            let dateInFormat = dateFormatter.string(from: todaysDate as Date)
//            atten.attendance_Date = dateFormatter.date(from: dateInFormat)
//            do{
//                try context.save()
//            }catch let error{
//                print(error.localizedDescription)
//            }
            
            
            //MARK :- present absent make 2 different button because its coming alternate present or absent on each cell
            self.employeeTableView.reloadData()
        }
        flag = 1
        ca.backgroundColor = UIColor.blue
        return UISwipeActionsConfiguration(actions: [ca])
        }else {
            let ca = UIContextualAction(style: .normal, title: "Absent") { [unowned self] (action, view, nil) in
             
                self.employeeTableView.reloadData()
            }
            flag = 0
            ca.backgroundColor = UIColor.blue
            return UISwipeActionsConfiguration(actions: [ca])
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EmployeeDetailViewController")as! EmployeeDetailViewController
        vc.employeeData = emparr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
