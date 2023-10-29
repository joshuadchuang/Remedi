//
//  UserHomeView.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI

struct UserHomeView: View {
    @EnvironmentObject var viewModel: AppViewModel

    @State private var medications = [
        Medication(name: "Aspirin", time: Calendar.current.date(bySettingHour: 13, minute: 30, second: 0, of: Date())!, dosage: "2 pills"),
        Medication(name: "Vitamin C", time: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!, dosage: "1 pill"),
        Medication(name: "Ibuprofen", time: Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date())!, dosage: "1 pill")
    ]

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Text("Today's Date: \(formatDate(Date()))")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                
                ScrollView {
                    ForEach(medications.filter { $0.time >= Date() }) { medication in
                        NavigationLink(destination: MedicationInfoView(medication: medication).environmentObject(viewModel)) {
                            MedicationView(medication: medication)
                        }
                    }
                    
                    
                }
                
                Spacer()
                
                HStack {
                    
                    NavigationLink(destination: ListMedicationView()) {
                        Rectangle()
                            .frame(width: 75, height: 75)
                            .foregroundStyle(.white)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .overlay(Image(systemName: "list.bullet")
                                .resizable()
                                .foregroundStyle(LinearGradient(gradient:
                                    Gradient(colors: [Color("OceanBlue"), Color("GrassGreen")]),
                                    startPoint: .topLeading,
                                    endPoint:.bottomTrailing))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40))
                            
                    }
                    
                    NavigationLink(destination: AddMedicationView().environmentObject(viewModel)) {
                        AddMedicationBlock()
                    }
                    
                    NavigationLink(destination: ProfileView()) {
                        Rectangle()
                            .frame(width: 75, height: 75)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .overlay(Image(systemName: "person.crop.circle")
                                .resizable()
                                .foregroundStyle(LinearGradient(gradient:
                                    Gradient(colors: [Color("OceanBlue"), Color("GrassGreen")]),
                                    startPoint: .topLeading,
                                    endPoint:.bottomTrailing))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40))
                    }
                }
            .padding()
        }
    }
}
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct UserHomeView_Previews: PreviewProvider {
    static var previews: some View {
        UserHomeView().environmentObject(AppViewModel())
    }
}
