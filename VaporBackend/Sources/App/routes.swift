import Vapor

func routes(_ app: Application) throws {
    let userController = UserController()
    
    // Create
    app.post("user", use: userController.createUser)
    // Read(basically get)
    app.get("user", ":uniqueCode", use: userController.getUser)
    // Update
    app.put("user", ":uniqueCode", use: userController.updateUser)
    // Delete
    app.delete("user", ":uniqueCode", use: userController.deleteUser)
    
    
    // Medication routes
    // Create
    app.post("user", ":uniqueCode", "medication", use: userController.createMedication)
    // Read all
    app.get("user", ":uniqueCode", "medications", use: userController.getAllMedications)
    // Read for today
    app.get("user", ":uniqueCode", "medications", "today", use: userController.getMedicationsForToday)
    // Update
    app.put("user", ":uniqueCode", "medication", use: userController.updateMedication)
    // Delete
    app.delete("user", ":uniqueCode", "medication", use: userController.deleteMedication)
}



//import Fluent
//import Vapor
//
//func routes(_ app: Application) throws {
//    app.get { req async throws in
//        try await req.view.render("index", ["title": "Hello Vapor!"])
//    }
//
//    app.get("hello") { req async -> String in
//        "Hello, world!"
//    }
//
//    try app.register(collection: TodoController())
//}
