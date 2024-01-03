//
//  ContentView.swift
//  chatSwift
//
//  Created by Felipe Avila on 11/12/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isLogged {
                MessageView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
