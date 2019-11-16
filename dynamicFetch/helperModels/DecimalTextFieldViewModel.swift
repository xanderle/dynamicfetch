//
//  File.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 13/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import Foundation
import Combine

public class DecimalTextFieldViewModel: ObservableObject {
    @Published var text = "0"
    private var subCancellable: AnyCancellable!
    private var validCharSet = CharacterSet(charactersIn: "1234567890")

    init() {
        subCancellable = $text.sink { val in
            //check if the new string contains any invalid characters
            if val.rangeOfCharacter(from: self.validCharSet.inverted) != nil {
                //clean the string (do this on the main thread to avoid overlapping with the current ContentView update cycle)
                DispatchQueue.main.async {
                    self.text = String(self.text.unicodeScalars.filter {
                        self.validCharSet.contains($0)
                    })
                }
            }
        }
    }

    deinit {
        subCancellable.cancel()
    }
}
