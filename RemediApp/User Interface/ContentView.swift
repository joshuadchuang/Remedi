//
//  ContentView.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/27/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = AppViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Remedi")
                    .font(.largeTitle)
                    .padding()
                
                Text("Your personal medication reminder assistant.")
                    .padding()
                
                Spacer()
                
                NavigationLink(destination: UserHomeView().environmentObject(viewModel)) {
                    Text("I am the User")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                NavigationLink(destination: CaretakerHomeView()) {
                    Text("I am the Caretaker")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
