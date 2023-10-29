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
            ZStack {
                BackgroundView()
                VStack(spacing: 10) {
                    TitleTextView(title: "Welcome to Remedi")
                    
                    Text("Your personal medication reminder assistant.")
                        .foregroundColor(.white)
                        .padding()
                    
                    VStack {
                        Image(systemName: "pills.circle")
                            .symbolRenderingMode(.palette)
                            .resizable()
                            .foregroundStyle(LinearGradient(gradient:
                                Gradient(colors: [Color("OceanBlue"), Color("GrassGreen")]),
                                startPoint: .topLeading,
                                endPoint:.bottomTrailing))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 220, height: 220)
                            .padding(.top)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: UserHomeView().environmentObject(viewModel)) {
                        Text("I am the User")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .foregroundStyle(LinearGradient(gradient:
                                Gradient(colors: [Color(""), Color("")]),
                                startPoint: .topLeading,
                                endPoint:.bottomTrailing))
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
}

struct BackgroundView: View {
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("Black2"), Color("DarkAqua")]),
                       startPoint: .topLeading,
                       endPoint:.bottomTrailing)
            .ignoresSafeArea()
    }
}

struct TitleTextView: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
