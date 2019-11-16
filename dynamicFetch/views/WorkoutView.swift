//
//  ExerciseView.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 10/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import SwiftUI
import CoreData

struct WorkoutView: View {
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    
    var workout: Workout
    
    var fetchRequest : FetchRequest<Exercise>

    var fetchedResults : FetchedResults<Exercise> {
        fetchRequest.wrappedValue
    }
    
    @State var exerciseName : String = ""
    
    
    init(workout : Workout) {
        self.workout = workout
        fetchRequest = FetchRequest(fetchRequest: Exercise.getExercises(workout: workout))
        print("Init")
    }
    var body: some View {
        KeyboardHost{
        ScrollView{
        VStack() {
            Text("Wednesday").font(.headline)
            
                ForEach(fetchedResults, id : \.self) { exercise in
                    ExerciseView(exercise : exercise)
                }.onDelete(perform: deleteItem)
                    .padding()

                Button(action: addItem) {
                    HStack{
                        TextField("Exercise Name", text: $exerciseName)
                    Text("Add exercise")
                        
                    }
                
            }
            Spacer()
        }
        .padding()
            .navigationBarTitle(workout.name ?? "Untitled")
            }
        
        }
    }
    
    func deleteItem(indexSet: IndexSet) {
        let node = fetchedResults[indexSet.first!]
        managedObjectContext.delete(node)
        saveItems(managedObjectContext: managedObjectContext)
    }

    func addItem() {
        if self.exerciseName != "" {
            let exercise = Exercise(context: managedObjectContext)
            exercise.name = self.exerciseName
            exercise.workout = workout
            saveItems(managedObjectContext: managedObjectContext)

            self.exerciseName=""
        }
    }

//    func saveItems() {
//        do {
//            try managedObjectContext.save()
//        } catch {
//            print(error)
//        }
//    }
    
}


struct WorkoutView_Previews: PreviewProvider {
    
    static var previews: some View {
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var workout = Workout(context : context)
        return WorkoutView(workout : workout)
    }
}


