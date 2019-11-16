//
//  WorkoutModel.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 10/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import CoreData

class Workout: NSManagedObject {
    @NSManaged var id : UUID
    @NSManaged var name : String?
    @NSManaged var date : Date
    @NSManaged var exercises : NSSet?
}

extension Workout {
    static func getWorkouts() -> NSFetchRequest<Workout> {
        let request = Workout.fetchRequest() as! NSFetchRequest<Workout>
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return request
    }
}
