//
//  Employee+CoreDataProperties.swift
//  FelixEmployeeAttendance
//
//  Created by ashutosh deshpande on 26/11/2022.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var address: String?
    @NSManaged public var blood_group: String?
    @NSManaged public var contact_number: Int64
    @NSManaged public var date_of_birth: Date?
    @NSManaged public var date_of_joining: Date?
    @NSManaged public var gender: String?
    @NSManaged public var id: Int64
    @NSManaged public var mail_id: String?
    @NSManaged public var name: String?
    @NSManaged public var salary: Int64
    @NSManaged public var attendance: Attendance?

}

extension Employee : Identifiable {

}
