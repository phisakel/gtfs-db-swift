# gtfs-db-swift
This library will allow you to query and update [GTFS](https://gtfs.org) data from an SQLite database in Swift. 

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fphisakel%2Fgtfs-db-swift%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/phisakel/gtfs-db-swift)  [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fphisakel%2Fgtfs-db-swift%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/phisakel/gtfs-db-swift)  [![Swift Build](https://github.com/phisakel/gtfs-db-swift/actions/workflows/swift.yml/badge.svg)](https://github.com/phisakel/gtfs-db-swift/actions/workflows/swift.yml)

## Installation
### Swift Package Manager
Add the following dependency to your `Package.swift` file:
```swift    
dependencies: [.package(url: "https://github.com/phisakel/gtfs-db-swift.git", from: "0.3.0")]
```
and to the target:
```swift
dependencies: [.product(name: "GtfsDb", package: "gtfs-db-swift")]
```

## Create the SQLite Database

### Programmatically
You can create a new GTFS database with all required tables using `GtfsDb.createDatabase(at:)`:
```swift
import GtfsDb

let database = try GtfsDb.createDatabase(at: "path/to/your/database.sqlite")
```
This creates the database file and runs all GTFS schema migrations (agency, stops, routes, trips, stop_times, calendar, calendar_dates, fare_rules, shapes, frequencies, transfers, pathways, feed_info, translations, attributions).

### Using node-GTFS
Alternatively, you can create the SQLite database using the `gtfs-import` command line tool from the [node-GTFS](https://github.com/BlinkTagInc/node-gtfs) library. First, download the GTFS zip and then run the import command, for example:
```bash
gtfs-import --gtfsPath ./9_google_transit.zip --sqlitePath ./9_google_transit.sqlite
```

## Usage
Read the GTFS data from the SQLite database, using the excellent [GRDB](https://github.com/groue/GRDB.swift) library, which is included as a dependency to this library. The following code will read the stops from the database:
```swift
import GtfsDb
import GRDB

func fetchStops() async throws -> [Stop] {
    let dbPath = "path/to/your/database.sqlite"
    var config = Configuration()
    config.readonly = true
    let dbQueue = try DatabaseQueue(path: dbPath, configuration: config)
    let stops = try await dbQueue.read { db in try Stop.fetchAll(db) }
    return stops
}
```

### Schema Migrator
For advanced use cases you can access the `DatabaseMigrator` directly via `makeMigrator()` to apply GTFS schema migrations to any GRDB database:
```swift
import GtfsDb
import GRDB

let database = try DatabaseQueue()
let migrator = makeMigrator()
try migrator.migrate(database)
```

## Release Notes
Publishing a GitHub release now automatically updates the release body with:
- A short `Highlights` section (top commit summaries)
- A full `What's Changed` list
- A compare link to the previous tag

The workflow is defined in `.github/workflows/release-notes.yml` and uses `scripts/generate-release-notes.sh`.

You can also generate notes locally:
```bash
bash scripts/generate-release-notes.sh v0.4.0
```
 
