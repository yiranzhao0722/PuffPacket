import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import SwiftKueryORM
import SwiftKueryPostgreSQL

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class App {
    let router = Router()
    let cloudEnv = CloudEnv()

    public init() throws {
        // Configure logging
        initializeLogging()
        // Run the metrics initializer
        initializeMetrics(router: router)
    }

    func postInit() throws {
        // Endpoints
        initializeHealthRoutes(app: self)
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
    
    func establishConnection() {
        var dbHost = URL(string: "localhost")!
        if let requestedHost = ProcessInfo.processInfo.environment["DATABASE_URL"] {
            print("The DATABASE_URL was found. It is \(requestedHost)")
            let urlComp = URLComponents(string: requestedHost)
            urlComp?.scheme = "Postgres"
            if let url = urlComp?.url {
                dbHost = URL(string: requestedHost)!
            }
        }
        
        let databaseName = "Backend"
        let userName = "root"
        let password = "admin"
        let pool = PostgreSQLConnection.createPool(host: dbHost.absoluteString, port: 5432, options: [.databaseName(databaseName), .userName(userName), .password(password)], poolOptions: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50))
        Database.default = Database(pool)
    }
    
    func postInit() throws {
        // Endpoints
        initializeHealthRoutes(app: self)
        
        // Establish database connection
        establishConnection()
        
        // Handle HTTP GET requests to "/"
        router.get("/users", handler: getAllUsers)
        router.get("/users", handler: getUserWithID)
    }

    func getAllUsers(completion: @escaping ([User]?, RequestError?) -> Void ) {
        User.findAll(completion)
    }

    func getUserWithID(id: Int, completion: @escaping (User?, RequestError?) -> Void ) {
        User.findAll(id: id, completion)
    }
}
