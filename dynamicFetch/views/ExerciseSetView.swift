//
//  ExerciseSetView.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 10/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import SwiftUI
import CoreData
import Foundation

struct ExerciseSetView: View {
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext

    @ObservedObject private var weight = DecimalTextFieldViewModel()
    @ObservedObject private var reps = DecimalTextFieldViewModel()
    
    var exerciseSet : ExerciseSet
    var set: Int
    @State var confirmDelete = false
    
    init(exerciseSet : ExerciseSet, set : Int) {
        self.exerciseSet = exerciseSet
        self.set = set
        self.reps.text = "\(self.exerciseSet.reps ?? 0)"
        self.weight.text = "\(self.exerciseSet.weight ?? 0)"
    }
    
    var body: some View {
        HStack {
            Text("\(set)")
            Spacer()
            TextField("\(self.reps.text)", text : self.$weight.text,onEditingChanged: { (changed) in
                self.updateRow()
                
            }) {self.updateRow()}
                .keyboardType(.numberPad)
            
            Spacer()
            TextField("\(self.weight.text)",text: self.$reps.text, onEditingChanged: { (changed) in
                self.updateRow()}
                      ){self.updateRow()}.keyboardType(.numberPad)
            Spacer()
            deleteButton.animation(.default)
        }.onAppear() {
            //self.sets = "\(self.exerciseSet.set)"
            
        }
        
        
    }
    
    func updateRow() {
        print("Updating")
        let formatter = NumberFormatter()
        exerciseSet.reps = formatter.number(from: self.reps.text)
        exerciseSet.weight = formatter.number(from : self.weight.text)
        saveChanges(context: self.managedObjectContext)
        
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
                deleteObject(context : self.managedObjectContext, object : self.exerciseSet)
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
        exerciseSet.date = Date()
        return ExerciseSetView(exerciseSet : exerciseSet, set : 0)
        
    }
}
