//
//  ExerciseSetView.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 10/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import SwiftUI
import CoreData

struct ExerciseSetView: View {
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    
    @ObservedObject private var weight = DecimalTextFieldViewModel()
    @ObservedObject private var reps = DecimalTextFieldViewModel()
    
    var exerciseSet : ExerciseSet
    var set: Int
    @State var confirmDelete = false
    var body: some View {
        HStack {
            Text("\(set)")
            Spacer()
            TextField("", text : self.$weight.text).keyboardType(.numberPad)
            Spacer()
            TextField("",text: self.$reps.text).keyboardType(.numberPad)
            Spacer()
            deleteButton.animation(.default)
        }.onAppear() {
            //self.sets = "\(self.exerciseSet.set)"
            self.reps.text = "\(self.exerciseSet.reps ?? 0)"
            self.weight.text = "\(self.exerciseSet.weight ?? 0)"
        }
        
    }
    func deleteItem() {
        
        managedObjectContext.delete(self.exerciseSet)
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    @ViewBuilder
    var deleteButton : some View {
        
        if !confirmDelete {
            Button(action : {
                self.confirmDelete.toggle()
            }) {
                Image(systemName : "minus.circle")
            }
        }
        else{
            
            Button(action : {
                self.deleteItem()
            }){
                Image(systemName : "checkmark.circle")
            }
        }
    }
}




struct ExerciseSetView_Previews: PreviewProvider {
    
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var exerciseSet = ExerciseSet(context : context)
        exerciseSet.set = 0
        return ExerciseSetView(exerciseSet : exerciseSet, set : 0)
        
    }
}
