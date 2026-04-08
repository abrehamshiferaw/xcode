import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

public func configure(_ app: Application) throws { // Removed 'async'
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    
    app.migrations.add(CreateReport())
    
    // Use .wait() instead of await for older macOS versions
    try app.autoMigrate().wait()

    app.views.use(.leaf)
    try routes(app)
}
