//
//  KeyboardHost.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 15/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import SwiftUI


struct KeyboardHost<Content: View>: View {
    let view: Content

    @State private var keyboardHeight: CGFloat = 0

    private let showPublisher = NotificationCenter.Publisher.init(
        center: .default,
        name: UIResponder.keyboardWillShowNotification
    ).map { (notification) -> CGFloat in
        if let rect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
            return rect.size.height
        } else {
            return 0
        }
    }

    private let hidePublisher = NotificationCenter.Publisher.init(
        center: .default,
        name: UIResponder.keyboardWillHideNotification
    ).map {_ -> CGFloat in 0}

    // Like HStack or VStack, the only parameter is the view that this view should layout.
    // (It takes one view rather than the multiple views that Stacks can take)
    init(@ViewBuilder content: () -> Content) {
        view = content()
    }

    var body: some View {
        VStack {
            view
                .padding(.bottom, self.keyboardHeight)
                .animation(nil)
            
//            Rectangle()
//                .frame(height: keyboardHeight)
//                //.animation(Animation.easeInOut(duration : 0.01))
//                .foregroundColor(.clear)
        }.onReceive(showPublisher.merge(with: hidePublisher)) { (height) in
            self.keyboardHeight = height
        }
        
    }
}
//
//struct KeyboardHost_Previews: PreviewProvider {
//    static var previews: some View {
//        KeyboardHost()
//    }
//}
