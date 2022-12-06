//
//  AttendanceViewController.swift
//  FelixEmployeeAttendance
//
//  Created by ashutosh deshpande on 28/11/2022.
//

import UIKit

class AttendanceViewController: UIViewController {
    @IBOutlet weak var attendanceTableView: UITableView!
    var attenArr : [Attendance] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetch()
    }
    func fetch(){
        do{
            attenArr = try context.fetch(Attendance.fetchRequest())
            DispatchQueue.main.async {
                self.attendanceTableView.reloadData()
            }
        }catch let error{
            print(error.localizedDescription)
        }
    }
}

extension AttendanceViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attenArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AttendanceTableViewCell
        let attend = attenArr[indexPath.row]
        cell.attendanceIdLabel.text = String(attend.attendance_Id)
        cell.idLabel.text = String(attend.id)
        cell.nameLabel.text = attend.name
        let today = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        cell.dateLabel.text = dateFormatter.string(from: (attend.attendance_Date ?? today as Date))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(109.0)
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let arr = attenArr[indexPath.row]
        let ca = UIContextualAction(style: .destructive, title: "Delete") { [unowned self](action, view, nil) in
        
            let a = UIAlertController(title: "Delete", message: "Do you want to Delete?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [unowned self] (action) in
                self.context.delete(arr)
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
}

