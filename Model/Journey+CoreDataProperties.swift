//
//  Journey+CoreDataProperties.swift
//  Block
//
//  Created by Andrew Campbell on 21/9/2023.
//
//

import Foundation
import CoreData


extension Journey {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Journey> {
        return NSFetchRequest<Journey>(entityName: "Journey")
    }
    
    @NSManaged public var color: String?
    @NSManaged public var id: UUID?
    @NSManaged public var progress: Int32
    @NSManaged public var target: Int32
    @NSManaged public var category: String?
    @NSManaged public var title: String?
    @NSManaged public var block: NSSet?
    @NSManaged public var completed: NSNumber?
    
    public var blockArray: [Block] {
        let set = block as? Set<Block> ?? []
        return set.sorted{$0.unwrappedTimestamp < $1.unwrappedTimestamp}
    }
    
}

// MARK: Generated accessors for block
extension Journey {
    
    @objc(addBlockObject:)
    @NSManaged public func addToBlock(_ value: Block)
    
    @objc(removeBlockObject:)
    @NSManaged public func removeFromBlock(_ value: Block)
    
    @objc(addBlock:)
    @NSManaged public func addToBlock(_ values: NSSet)
    
    @objc(removeBlock:)
    @NSManaged public func removeFromBlock(_ values: NSSet)
    
}

extension Journey : Identifiable {
    
}

