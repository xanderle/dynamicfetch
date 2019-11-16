//
//  Utility.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 12/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import Foundation
import CoreData

func saveItems(managedObjectContext : NSManagedObjectContext) {
    do {
        try managedObjectContext.save()
    } catch {
        print(error)
    }
}
