//
//  Medication.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import Foundation
import SwiftUI

struct Medication: Identifiable {
    var id = UUID()
    var name: String
    var time: Date
    var dosage: String

    var timeFormatted: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }
}
