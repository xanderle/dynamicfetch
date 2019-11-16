//
//  HelperFunctions.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 16/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import Foundation
import CoreData


func deleteObject(context : NSManagedObjectContext, object : NSManagedObject) {
    context.delete(object)
    saveChanges(context : context)
}

func saveChanges(context : NSManagedObjectContext) {
    do {
        try context.save()
    }
    catch {
        print(error)
    }
}
