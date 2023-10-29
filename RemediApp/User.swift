//
//  User.swift
//  RemediApp
//
//  Created by Albert Su on 10/29/23.
//

import Foundation
import SwiftUI

struct User: Codable {
    var uniqueCode: String
    var name: String
    var medications: [Medication]
}
