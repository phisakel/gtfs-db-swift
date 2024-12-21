import Testing
import GRDB
import GTFS
@testable import GtfsDb

@Suite("GTFS table count tests")
struct GtfsDbTests {
    static let dbPath = "/Users/ffeli/Source/PhilipSoftware/BusCyprus/NPT_9_google_transit.sqlite"
    var dbQueue: DatabaseQueue

    init() throws {
        var config = Configuration()
        config.readonly = true
        dbQueue = try DatabaseQueue(path: GtfsDbTests.dbPath, configuration: config)
    }
 
    @Test func read_agencies() async throws {
        let count = try await dbQueue.read { db in try Agency.fetchCount(db) }
        print("agencies", count)
    }

    @Test func read_routes() async throws {
        let count = try await dbQueue.read { db in try Route.fetchCount(db) }
        print("routes", count)
    }

    @Test func read_stops() async throws {
        let count = try await dbQueue.read { db in try Stop.fetchCount(db) }
        print("stops", count)
    }

    @Test func read_trips() async throws {
        let count = try await dbQueue.read { db in try Trip.fetchCount(db) }
        print("trips", count)
    }

    @Test func read_stop_times() async throws {
        let count = try await dbQueue.read { db in try StopTime.fetchCount(db) }
        print("stop_times", count)
    }

    @Test func read_calendar() async throws {
        let count = try await dbQueue.read { db in try GTFSCalendar.fetchCount(db) }
        print("calendar", count)
    }

    @Test func read_calendar_dates() async throws {
        let count = try await dbQueue.read { db in try CalendarDate.fetchCount(db) }
        print("calendar_dates", count)
    }

    @Test func read_fare_rules() async throws {
        let count = try await dbQueue.read { db in try FareRule.fetchCount(db) }
        print("fare_rules", count)
    }
    
    @Test func read_shapes() async throws {
        let count = try await dbQueue.read { db in try Shape.fetchCount(db) }
        print("shapes", count)
    }

    @Test func read_frequencies() async throws {
        let count = try await dbQueue.read { db in try Frequency.fetchCount(db) }
        print("frequencies", count)
    }

    @Test func read_transfers() async throws {
        let count = try await dbQueue.read { db in try Transfer.fetchCount(db) }
        print("transfers", count)
    }

    @Test func read_pathways() async throws {
        let count = try await dbQueue.read { db in try Pathway.fetchCount(db) }
        print("pathways", count)
    }

    @Test func read_feed_info() async throws {
        let count = try await dbQueue.read { db in try FeedInfo.fetchCount(db) }
        print("feed_info", count)
    }    

    @Test func read_translations() async throws {
        let count = try await dbQueue.read { db in try Translation.fetchCount(db) }
        print("translations", count)
    }   

    @Test func read_attributions() async throws {
        let count = try await dbQueue.read { db in try Attribution.fetchCount(db) }
        print("attributions", count)
    }          
    
}
