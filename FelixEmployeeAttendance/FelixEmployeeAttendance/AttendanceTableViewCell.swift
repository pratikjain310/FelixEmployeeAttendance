//
//  AttendanceTableViewCell.swift
//  FelixEmployeeAttendance
//
//  Created by ashutosh deshpande on 28/11/2022.
//

import UIKit

class AttendanceTableViewCell: UITableViewCell {

    @IBOutlet weak var attendanceIdLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

