//
//  Medication.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import Foundation
import SwiftUI

struct Medication: Identifiable, Codable {
    var id = UUID()
    var name: String
    var time: Date
    var dosage: String
    var startDate: Date
    var frequencyPerDay: Int
    var duration: Int // in days
}
