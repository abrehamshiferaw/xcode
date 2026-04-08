import Fluent
import Vapor

func routes(_ app: Application) throws {
//   Register the controller we just created
    try app.register(collection: ReportController())
}
