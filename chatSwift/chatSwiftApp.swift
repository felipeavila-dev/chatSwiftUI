//
//  chatSwiftApp.swift
//  chatSwift
//
//  Created by Felipe Avila on 04/12/23.
//

import SwiftUI
import FirebaseCore
//import FirebaseAuth

@main
struct chatSwiftApp: App {
    
    init() {
        FirebaseApp.configure()
//        try! Auth.auth().signOut()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension UIApplication {
    func hiddenKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
