//
//  PersonCD+CoreDataProperties.swift
//  
//
//  Created by Zayd on 25.11.2019.
//
//

import Foundation
import CoreData


extension PersonCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonCD> {
        return NSFetchRequest<PersonCD>(entityName: "PersonCD")
    }

    @NSManaged public var created: String?
    @NSManaged public var episode: Int32
    @NSManaged public var gender: String?
    @NSManaged public var id: Int32
    @NSManaged public var image: Data?
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var status: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?

}
