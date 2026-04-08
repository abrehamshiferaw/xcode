import Fluent
import Vapor

struct ReportController: RouteCollection {
    func boot(routes: RoutesBuilder ) throws {
//        shows staff input form at the root URL("/")
        routes.get(use: indexView)
//        Group all "/report" routes together
        
        let reports = routes.grouped("report")
//        Handle Form Submission (POST "/report")
        
        reports.post(use: create)
//        show parent view (Readonly) (GET "/report/1234-abcyz..."
        reports.get(":reportID", use: showParentView)
        
    }
    
//    Now let's render the form html page
    
    func indexView(req: Request) throws -> EventLoopFuture<View> {
        return req.view.render("components/index")
    }
    
//    save the submitted form to SQLite and redirect to the new link
    
    func create(req: Request) throws -> EventLoopFuture<Response> {
        let report = try req.content.decode(Report.self)
        
        return report.save(on: req.db).flatMapThrowing {
            guard let id = report.id
        else{
            throw Abort(.internalServerError)
        }
        
//         redirect to the newly generated unique URL
        return req.redirect(to: "/report/\(id.uuidString)")
    }
    
}

// here we will render the parent read-only page using the data from SQLite
func showParentView(req: Request) throws -> EventLoopFuture<View> {
    guard let reportIDString = req.parameters.get("reportID"),
          let reportID = UUID(uuidString: reportIDString) else {
              throw Abort(.badRequest)
          }
    return Report.find(reportID, on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap {
            report in return req.view.render("components/report", ["report": report])
        }
}

}
