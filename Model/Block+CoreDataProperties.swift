//
//  Block+CoreDataProperties.swift
//  Block
//
//  Created by Andrew Campbell on 21/9/2023.
//
//

import Foundation
import CoreData


extension Block {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Block> {
        return NSFetchRequest<Block>(entityName: "Block")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var timestamp: Date?
    @NSManaged public var origin: Journey?
    
    public var unwrappedTimestamp: Date {
        let date = Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1))!
        
        return timestamp ?? date
    }

}

extension Block : Identifiable {
    
}
