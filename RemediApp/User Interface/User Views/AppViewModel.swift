//
//  AppViewModel.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI

class AppViewModel: ObservableObject {
    @Published var selectedMedication: Medication?
}

//
//struct AppViewModel: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct AppViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        AppViewModel()
//    }
//}
