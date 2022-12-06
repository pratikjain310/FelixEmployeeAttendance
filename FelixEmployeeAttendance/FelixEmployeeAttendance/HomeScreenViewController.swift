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
    
    
    
    func markPresent(attend : Attendance, emp : Employee){
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateInFormat = dateFormatter.string(from: todaysDate as Date)
        attend.id = emp.id
        attend.name = emp.name
        attend.attendance_Date = dateFormatter.date(from: dateInFormat)
        do{
            try context.save()
            fetch()
            fetch1()
        }catch let error{
            print(error.localizedDescription)
        }
        let alert = UIAlertController(title: "Alert", message: "Marked As Present", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { [unowned self] (action) in
            self.employeeTableView.reloadData()
            tabBarController?.selectedIndex = 2
        }
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //MARK :- Present Section
        let presentAction = UIContextualAction(style: .normal, title: "Present") { [unowned self] (action, view, nil) in
            let attend = Attendance(context: context)
            let emp = emparr[indexPath.row]
            
            if attenarr.isEmpty {
                attend.attendance_Id = 1
                markPresent(attend: attend, emp: emp)
            }else {
                let a = attenarr.filter{ $0.id == emp.id }
                if a.isEmpty{
                    let last = attenarr.last
                    var id = last?.id
                    id! += 1
                    attend.attendance_Id = id!
                    markPresent(attend: attend, emp: emp)
                }else {
                    let alert = UIAlertController(title: "Alert", message: "Already Marked As Present", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .cancel) { [unowned self] (action) in
                        self.employeeTableView.reloadData()
                        tabBarController?.selectedIndex = 2
                    }
                    alert.addAction(okAction)
                    present(alert, animated: true)
                } // MARK :- Write proper code for present and absent not working properly
            }
        }
        presentAction.backgroundColor = UIColor.brown
        
        
        //MARK :- Absent Section
        let absentAction = UIContextualAction(style: .normal, title: "Absent") { [unowned self] (action, view, nil) in
            if attenarr.isEmpty {
                let alert = UIAlertController(title: "Alert", message: "No record found to mark Absent", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel) { [unowned self] (action) in
                    self.employeeTableView.reloadData()
                }
                alert.addAction(okAction)
                present(alert, animated: true)
            }else {
                let emp = emparr[indexPath.row]
                let attend = attenarr[indexPath.row]
                if attend.id == emp.id{
                    let todaysDate = NSDate()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let dateInFormat = dateFormatter.string(from: todaysDate as Date)
                    let currentDate = dateFormatter.date(from: dateInFormat)
                    if attend.attendance_Date == currentDate{
                        context.delete(attend)
                        try? context.save()
                        let alert = UIAlertController(title: "Alert", message: "Marked As Absent", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .cancel) { [unowned self] (action) in
                            self.employeeTableView.reloadData()
                            tabBarController?.selectedIndex = 2
                        }
                        alert.addAction(okAction)
                        present(alert, animated: true)
                    }
                }
            }
            
            self.employeeTableView.reloadData()
        }
        absentAction.backgroundColor = UIColor.brown
        
        return UISwipeActionsConfiguration(actions: [presentAction, absentAction])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EmployeeDetailViewController")as! EmployeeDetailViewController
        vc.employeeData = emparr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
