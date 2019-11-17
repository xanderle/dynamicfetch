//
//  ExerciseView.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 12/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import SwiftUI
import CoreData

struct ExerciseView: View {
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    
    @State private var editMode: EditMode = .inactive
    var fetchRequest : FetchRequest<ExerciseSet>
    
    var fetchedResults : FetchedResults<ExerciseSet> {
        fetchRequest.wrappedValue
    }
    
    var exercise : Exercise
    
    init(exercise : Exercise) {
        self.exercise = exercise
        fetchRequest = FetchRequest(fetchRequest: ExerciseSet.getExerciseSets(exercise: exercise))
        print("Init")
    }
    
    var body: some View {
        VStack {
            HStack{Text(exercise.name)
                Spacer()
                Button(action : {
                    self.deleteExercise()
                }){
                    Image(systemName : "minus.square")
                }
            }
            HStack{
                Text("Sets")
                Spacer()
                Text("Weight")
                Spacer()
                Text("Reps")
                Spacer()
                Text("Done")
            }
            
            ForEach(fetchedResults.indices, id: \.self) { index in
                ExerciseSetView(exerciseSet : self.fetchedResults[index], set : index)
                
            }.onDelete(perform: self.deleteItem)
            //            }
            Button(action : {
                
                let exerciseSet = ExerciseSet(context : self.managedObjectContext)
                exerciseSet.date = Date()
                //                    exerciseSet.set = NSNumber(value : self.fetchedResults.count + 1)
                exerciseSet.exercise = self.exercise
                saveItems(managedObjectContext: self.managedObjectContext)
                print("Added")
                
            }) {
                Text("Add set")
                
            }
            
        }.navigationBarItems(leading: HStack{
            Spacer()
            EditButton()
        })
            .environment(\.editMode, self.$editMode)
    }
    func deleteExercise() {
        
        managedObjectContext.delete(self.exercise)
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func deleteItem(indexSet: IndexSet) {
        
        let node = fetchedResults[indexSet.first!]
        managedObjectContext.delete(node)
        saveItems(managedObjectContext: self.managedObjectContext)
    }
    
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let exercise = Exercise(context : context)
        exercise.name = "Something"
        let exerciseSet = ExerciseSet(context : context)
        exerciseSet.date = Date()
        exerciseSet.exercise = exercise
        
        return ExerciseView(exercise : exercise)
    }
}
