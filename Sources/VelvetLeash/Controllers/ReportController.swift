import Fluent
import Vapor

// 1. Create a simple struct that leaf can easily read(no database wrappers!)
struct ReportContext: Encodable {
    let petName: String
    let energyLevel: Int
    let mealConsumption: String
    let bestFriend: String?
    let staffNotes: String?
}

struct ReportController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: indexView)
        
        let reports = routes.grouped("report")
        reports.post(use: create)
        reports.get(":reportID", use: showParentView)
    }
    
    func indexView(req: Request) throws ->EventLoopFuture<View> {
        return req.view.render("components/index")
    }
    
    func create(req: Request) throws -> EventLoopFuture<Response> {
        let report = try req.content.decode(Report.self)
        return report.save(on: req.db).flatMapThrowing {
            guard let id = report.id
            else {
                throw Abort(.internalServerError)
            }
            
            return req.redirect(to: "/report/\(id.uuidString)")
        }
    }
    func showParentView(req: Request) throws -> EventLoopFuture<View> {
        guard let reportIDString = req.parameters.get("reportID"),
              let reportID = UUID(uuidString: reportIDString) else {
                  throw Abort(.badRequest)
              }
        
        return Report.find(reportID, on: req.db).unwrap(or: Abort(.notFound))
            .flatMap{
                report in
//                extract the plain values from the database ,model
                
                let safeContext = ReportContext(
                    petName: report.petName,
                    energyLevel: report.energyLevel,
                    mealConsumption: report.mealConsumption,
                    bestFriend: report.bestFriend,
                    staffNotes: report.staffNotes
                    )
//                hand the safe plain-text context to Leaf instead
                return req.view.render("components/report", ["report": safeContext])
            }
    }
}
