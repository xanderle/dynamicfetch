//
//  ExerciseSets.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 10/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import CoreData


//class Exercise : NSManagedObject {
//    @NSManaged var name : String
//    @NSManaged var order : Int16
//    @NSManaged var workout : Workout
//}

class ExerciseSet: NSManagedObject {
    
    @NSManaged var exercise : Exercise
    @NSManaged var date : Date
    @NSManaged var reps : NSNumber?
    @NSManaged var weight : NSNumber?
}

extension ExerciseSet{
    static func getExerciseSets(exercise : Exercise?) -> NSFetchRequest<ExerciseSet> {
           let request = ExerciseSet.fetchRequest() as! NSFetchRequest<ExerciseSet>
           request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
            request.predicate = NSPredicate(format: "exercise = %@", exercise ?? NSNull())
           return request
       }
}
