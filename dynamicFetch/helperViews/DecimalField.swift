//
//  DecimalField.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 16/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import SwiftUI

import UIKit
import Foundation



struct DecimalField : View {
    let label: String
    @Binding var value: Int?
    let formatter: NumberFormatter
    @State var displayedText: String? = nil
    @State var lastFormattedValue: Decimal? = nil
    
    var body: some View {
        let b = Binding<String>(
            get: { return self.displayedText ?? "" },
            set: { newValue in
                self.displayedText = newValue
                self.value = self.formatter.number(from: newValue)?.intValue
        })
        
        return TextField(label, text: b, onEditingChanged: { inFocus in
            if !inFocus {
                self.lastFormattedValue = self.formatter.number(from: b.wrappedValue)?.decimalValue
                if self.lastFormattedValue != nil {
                    DispatchQueue.main.async {
                        b.wrappedValue = self.formatter.string(for: self.lastFormattedValue!) ?? ""
                    }
                }
            }
        })
            .padding()
            .keyboardType(.numberPad)
    }
}
