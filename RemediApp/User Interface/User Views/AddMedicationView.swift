//
//  AddMedicationView.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI

struct AddMedicationView: View {
    @StateObject var viewModel = AppViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Add a Medication")
                    .font(.largeTitle)
                    .padding()
                
                Text("Choose to input information yourself (manually), or take a picture of the prescription")
                    .padding()
                
                Spacer()
                
                NavigationLink(destination: MedicationInputForm().environmentObject(viewModel)) {
                    Text("Manual Input")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                NavigationLink(destination: CamInputForm()) {
                    Text("Camera Input")
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

struct AddMedicationView_Previews: PreviewProvider {
    static var previews: some View {
        AddMedicationView()
    }
}
