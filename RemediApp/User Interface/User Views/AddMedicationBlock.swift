//
//  AddMedicationBlock.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI

struct AddMedicationBlock: View {
    var body: some View {
        VStack {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(Color.white)
            Text("Add Medication")
                .font(.headline)
                .foregroundStyle(Color.white)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
