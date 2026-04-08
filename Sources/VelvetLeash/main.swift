import Vapor

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)

let app = Application(env)

//I will write the configuration function latter

try configure(app)

//start the server
try app.run()
