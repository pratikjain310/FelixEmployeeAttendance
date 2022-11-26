//
//  Attendance+CoreDataProperties.swift
//  FelixEmployeeAttendance
//
//  Created by ashutosh deshpande on 26/11/2022.
//
//

import Foundation
import CoreData


extension Attendance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attendance> {
        return NSFetchRequest<Attendance>(entityName: "Attendance")
    }

    @NSManaged public var attendance_Id: Int64
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var attendance_Date: Date?
    @NSManaged public var employee: Employee?

}

extension Attendance : Identifiable {

}
