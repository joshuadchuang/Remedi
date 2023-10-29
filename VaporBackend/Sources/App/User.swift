//
//  User.swift
//
//
//  Created by Joshua Chuang on 10/28/23.
//

import Vapor

struct User: Codable {
    var uniqueCode: String
    var name: String
    var medications: [Medication]
}

extension User: Content {}

struct Medication: Codable {
    var id: UUID
    var name: String
    var dosage: String
    var startDate: Date
    var frequencyPerDay: Int
    var duration: Int // in days
    
    var datesAndTimes: [Date] {
        var datesTimes = [Date]()
        let calendar = Calendar.current
        let endDate = calendar.date(byAdding: .day, value: duration - 1, to: startDate)!
        var currentDate = startDate
        while currentDate <= endDate {
            let timeInterval = 12 * 60 * 60 / frequencyPerDay // 12 hours in seconds divided by frequency
            for i in 0..<frequencyPerDay {
                if let date = calendar.date(byAdding: .second, value: i * timeInterval, to: currentDate) {
                    datesTimes.append(date)
                }
            }
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return datesTimes
    }
}

extension Medication: Content {}
