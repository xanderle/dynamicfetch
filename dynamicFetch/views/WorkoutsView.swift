//
//  WorkoutView.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 10/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import SwiftUI
import CoreData

struct WorkoutsView: View {
    @State private var editMode: EditMode = .inactive

    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    
    var fetchRequest : FetchRequest<Workout>
    var fetchedResults : FetchedResults<Workout> {
        fetchRequest.wrappedValue
    }
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    init() {
        fetchRequest = FetchRequest(fetchRequest: Workout.getWorkouts())
    }
    var body: some View {
        
        NavigationView {
            List{
                ForEach(fetchedResults, id: \.self){ (workout : Workout) in
                    NavigationLink(destination : WorkoutView(workout: workout)) {
                        HStack{
                            Text("Date : \(workout.date, formatter: Self.dateFormatter)")
                            Text("\(workout.exercises?.count ?? 0)")
                        }
                    }
                }.onDelete(perform: deleteItem)
                    .navigationBarTitle("Workouts")
                    
                Button(action: {
                    var workout = Workout(context: self.managedObjectContext)
                    workout.date = Date()
                    workout.id = UUID()
                    saveItems(managedObjectContext: self.managedObjectContext)

                    
                }) {
                    Text("Add workout")
                }
                
            }
            .navigationBarTitle("Workouts")
            .navigationBarItems(trailing: HStack{
                EditButton()
            })
            .environment(\.editMode, self.$editMode)
        }
    
    }
    

    func deleteItem(indexSet: IndexSet) {
        let node = fetchedResults[indexSet.first!]
        managedObjectContext.delete(node)
        saveItems(managedObjectContext: self.managedObjectContext)
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
