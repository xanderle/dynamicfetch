//
//  CustomTextField.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 16/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//
import SwiftUI
import Foundation
import UIKit
struct CustomTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {
        
        var onEndEdit : ()->()
        @Binding var text: String
        

        init(text: Binding<String>, onEndEdit : @escaping()->()) {
            _text = text
            self.onEndEdit = onEndEdit
            
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            
            text = textField.text ?? ""
        }
        
        
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            self.onEndEdit()
        }

    }

    @Binding var text: String
    var onEndEdit : () -> ()
   

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.addDoneButtonOnKeyboard()
        textField.keyboardType = UIKeyboardType.numberPad
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text, onEndEdit: onEndEdit)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        // Text validation can be done here
        uiView.text = text

    }
}
