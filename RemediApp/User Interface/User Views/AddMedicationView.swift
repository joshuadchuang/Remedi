//
//  AddMedicationView.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI

struct AddMedicationView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
                VStack {
                    Text("Add a Medication")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("Choose to input information yourself (manually), or take a picture of the prescription")
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                    
                    NavigationLink(destination: MedicationInputForm().environmentObject(viewModel)) {
                        Text("Manual Input")
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .foregroundColor(.white)
                            .frame(maxWidth: 280, maxHeight: 50)
                            .background(LinearGradient(gradient:
                                Gradient(colors: [Color("OceanBlue"), Color("Green")]),
                                startPoint: .topLeading,
                                endPoint:.bottomTrailing))
                            .cornerRadius(10)
                            .padding()
                    }
                    
                    NavigationLink(destination: CamInputForm().environmentObject(viewModel)) {
                        Text("Camera Input")
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .foregroundColor(.white)
                            .frame(maxWidth: 280, maxHeight: 50)
                            .background(LinearGradient(gradient:
                                Gradient(colors: [Color("OceanBlue"), Color("Green")]),
                                startPoint: .topLeading,
                                endPoint:.bottomTrailing))
                            .cornerRadius(10)
                    }
                    
                Spacer()
            }
        }
    }
}

struct AddMedicationView_Previews: PreviewProvider {
    static var previews: some View {
        AddMedicationView().environmentObject(AppViewModel())
    }
}
