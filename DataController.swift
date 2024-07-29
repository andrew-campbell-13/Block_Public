//
//  DataController.swift
//  Block
//
//  Created by Andrew Campbell on 16/9/2023.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Block")

    init(){
        container.loadPersistentStores{description, error in
            if let error = error{
                print("Core Data failed to load: \(error.localizedDescription)")
            }

            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}

