import Leaf
import Vapor

// Called before your application initializes.
public func configure(_ app: Application) throws {
    // Register middleware
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Register Leaf
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease
    
    // Register routes
    try routes(app)
}



//import NIOSSL
//import Fluent
//import FluentMongoDriver
//import Leaf
//import Vapor
//
//// configures your application
//public func configure(_ app: Application) async throws {
//    // uncomment to serve files from /Public folder
//    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
//
//    try app.databases.use(DatabaseConfigurationFactory.mongo(
//        connectionString: Environment.get("DATABASE_URL") ?? "mongodb://localhost:27017/vapor_database"
//    ), as: .mongo)
//
//    app.migrations.add(CreateTodo())
//
//    app.views.use(.leaf)
//
//    
//
//    // register routes
//    try routes(app)
//}
