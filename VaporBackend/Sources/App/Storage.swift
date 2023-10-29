//
//  Storage.swift
//
//
//  Created by Joshua Chuang on 10/28/23.
//

import Vapor

class Storage {
    let fileManager = FileManager.default
    
    func readUser(uniqueCode: String) -> User? {
        let directory = fileManager.currentDirectoryPath
        let filePath = URL(fileURLWithPath: directory.appending("/Users/\(uniqueCode).json"))
        
        // Check if file exists
        guard fileManager.fileExists(atPath: filePath.path) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: filePath)
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            print("Failed to read data from file: \(error)")
            return nil
        }
    }
    
    func writeUser(user: User) {
        let directory = fileManager.currentDirectoryPath
        let filePath = URL(fileURLWithPath: directory.appending("/Users/\(user.uniqueCode).json"))
        
        // Create user directory if it does not exist
        let userDirectory = URL(fileURLWithPath: directory.appending("/Users"))
        if !fileManager.fileExists(atPath: userDirectory.path) {
            do {
                try fileManager.createDirectory(at: userDirectory, withIntermediateDirectories: true)
            } catch {
                print("Failed to create directory: \(error)")
            }
        }
        
        do {
            let data = try JSONEncoder().encode(user)
            try data.write(to: filePath)
        } catch {
            print("Failed to write data to file: \(error)")
        }
    }
}
