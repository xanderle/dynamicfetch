//
//  ContentView.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 10/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    @State var dollarValue: Int?
//        
//        
//
//        static var currencyFormatter: NumberFormatter {
//            let nf = NumberFormatter()
//            nf.numberStyle = .ordinal
//            nf.isLenient = true
//            return nf
//        }
//        
//        
//        var body: some View {
//            ScrollView {
//                VStack(alignment: .leading) {
//                    VStack {
//                        HStack {
//                            Text("Check Amount")
//                            Divider()
//                            DecimalField(label: "Amount", value: $dollarValue, formatter: Self.currencyFormatter)
//                            Divider()
//                        }
//  
//                    }
//                    .padding()
// 
//                }
//                .fixedSize(horizontal: false, vertical: true)
//                .padding()
//            }
//        }
//    }
    var body: some View {
        WorkoutsView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

