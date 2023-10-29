//
//  UserController.swift
//
//
//  Created by Joshua Chuang on 10/28/23.
//

import Foundation
import Vapor

final class UserController {
    func createUser(req: Request) async throws -> User {
        do {
            let user = try req.content.decode(User.self)
            let filePath = "Users/\(user.uniqueCode).json"

            // Check if file exists
            if !FileManager.default.fileExists(atPath: filePath) {
                // Create file
                FileManager.default.createFile(atPath: filePath, contents: nil)
            }

            // Write user data to file
            let jsonData = try JSONEncoder().encode(user)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                        // Log the JSON string
                        print("JSON String: \(jsonString)")
                    } else {
                        throw Abort(.internalServerError, reason: "Failed to convert JSON data to string")
                    }
            
            try jsonData.write(to: URL(fileURLWithPath: filePath))

            // Return a success response with the newly created user
            return user
        } catch {
            // Handle decoding or file-related errors
            throw Abort(.internalServerError, reason: "Failed to create user: \(error)")
        }
    }


    func getUser(req: Request) async throws -> User {
        
            req.logger.info("starting thingy")
        
            guard let uniqueCode = req.parameters.get("uniqueCode") else {
                throw Abort(.badRequest, reason: "uniqueCode not found in parameters")
            }
            
            let filePath = "Users/\(uniqueCode).json"
        
            req.logger.info("File Path: \(filePath)")

            // Check if file exists
            guard FileManager.default.fileExists(atPath: filePath) else {
                throw Abort(.badRequest, reason: "User file does not exist")
            }

            // Read user data from file
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                let user = try JSONDecoder().decode(User.self, from: data)
                return user
            } catch {
                print("Failed to read file or decode user: \(error)")
                throw error
            }
        }
    
    func updateUser(req: Request) async throws -> User {
        // Extract the uniqueCode from the request's parameters
        guard let uniqueCode = req.parameters.get("uniqueCode") else {
            throw Abort(.badRequest, reason: "uniqueCode not found in parameters")
        }
        
        // Decode the updated user data from the request's body
        let updatedUser = try req.content.decode(User.self)
        
        // Load the existing user from the file system
        let filePath = "Users/\(uniqueCode).json"
        guard let data = try? Data(base32Encoded: filePath),
              var user = try? JSONDecoder().decode(User.self, from: data) else {
            throw Abort(.notFound, reason: "User not found")
        }
        
        // Update the user's data
        user.name = updatedUser.name
        user.medications = updatedUser.medications
        
        // Save the updated user to the file system
        let updatedData = try JSONEncoder().encode(user)
        try updatedData.write(to: URL(fileURLWithPath: filePath))
        
        return user
    }

    func deleteUser(req: Request) async throws -> HTTPStatus {
        // Extract the uniqueCode from the request's parameters
        guard let uniqueCode = req.parameters.get("uniqueCode") else {
            throw Abort(.badRequest, reason: "uniqueCode not found in parameters")
        }
        
        // Load the existing user from the file system
        let filePath = "Users/\(uniqueCode).json"
        guard FileManager.default.fileExists(atPath: filePath) else {
            throw Abort(.notFound, reason: "User not found")
        }
        
        // Delete the user's file
        try FileManager.default.removeItem(atPath: filePath)
        
        return .noContent
    }
    
    func createMedication(req: Request) async throws -> User {
            let medication = try req.content.decode(Medication.self)
        let user = try await updateUserMedications(req: req, medication: medication, action: .add)
            return user
        }

        func getAllMedications(req: Request) async throws -> [Medication] {
            let user = try await getUser(req: req)
            return user.medications
        }

        func getMedicationsForToday(req: Request) async throws -> [Medication] {
            let user = try await getUser(req: req)
            let currentDate = Date()
            let calendar = Calendar.current
            return user.medications.filter { medication in
                let startDate = medication.startDate
                let endDate = medication.startDate.addingTimeInterval(Double(medication.duration) * 24 * 60 * 60)
                return currentDate >= startDate && currentDate <= endDate
            }.sorted(by: { $0.datesAndTimes[0] < $1.datesAndTimes[0] })
        }

        func updateMedication(req: Request) async throws -> User {
            let medication = try req.content.decode(Medication.self)
            let user = try await updateUserMedications(req: req, medication: medication, action: .update)
            return user
        }

        func deleteMedication(req: Request) async throws -> User {
            let medication = try req.content.decode(Medication.self)
            let user = try await updateUserMedications(req: req, medication: medication, action: .delete)
            return user
        }
        
        // Utility function to update user's medications
        private func updateUserMedications(req: Request, medication: Medication, action: UpdateAction) async throws -> User {
            // Extract the uniqueCode from the request's parameters
            guard let uniqueCode = req.parameters.get("uniqueCode") else {
                throw Abort(.badRequest, reason: "uniqueCode not found in parameters")
            }
            
            // Load the existing user from the file system
            let filePath = "Users/\(uniqueCode).json"
            guard let data = try? Data(base32Encoded: filePath),
                  var user = try? JSONDecoder().decode(User.self, from: data) else {
                throw Abort(.notFound, reason: "User not found")
            }
            
            switch action {
            case .add:
                user.medications.append(medication)
            case .update:
                if let index = user.medications.firstIndex(where: { $0.id == medication.id }) {
                    user.medications[index] = medication
                }
            case .delete:
                if let index = user.medications.firstIndex(where: { $0.id == medication.id }) {
                    user.medications.remove(at: index)
                }
            }
            
            // Save the updated user to the file system
            let updatedData = try JSONEncoder().encode(user)
            try updatedData.write(to: URL(fileURLWithPath: filePath))
            
            return user
        }
    }

    enum UpdateAction {
        case add, update, delete
    }


