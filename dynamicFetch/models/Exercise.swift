//
//  Exercise.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 10/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import CoreData

class Exercise : NSManagedObject {
    @NSManaged var name : String
    @NSManaged var order : Int16
    @NSManaged var workout : Workout
    @NSManaged var exerciseSet : NSSet?
}

extension Exercise {
    static func getExercises(workout : Workout?) -> NSFetchRequest<Exercise> {
        let request = Exercise.fetchRequest() as! NSFetchRequest<Exercise>
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: false)]
        request.predicate = NSPredicate(format: "workout = %@", workout ?? NSNull())
        return request
    }
   
}
