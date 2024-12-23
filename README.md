# gtfs-db-swift
This library will allow you to query and update [GTFS](https://gtfs.org) data from an SQLite database in Swift. 

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fphisakel%2Fgtfs-db-swift%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/phisakel/gtfs-db-swift)  [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fphisakel%2Fgtfs-db-swift%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/phisakel/gtfs-db-swift)

## Installation
### Swift Package Manager
Add the following dependency to your `Package.swift` file:
```swift    
dependencies: [.package(url: "https://github.com/phisakel/gtfs-db-swift.git", from: "0.1.0")]
```
and to the target:
```swift
dependencies: [.product(name: "GtfsDb", package: "gtfs-db-swift")]
```

## Create the sqlite database
You can create the sqlite database using the `gtfs-import` command line tool. You can install it from the [node-GTFS](https://github.com/BlinkTagInc/node-gtfs) library. First, download the GTFS zip and then run the import command, for example:
```bash
gtfs-import --gtfsPath ./9_google_transit.zip --sqlitePath ./9_google_transit.sqlite
```

## Usage
Read the GTFS data from the sqlite database, using the excellent [GRDB](https://github.com/groue/GRDB.swift) library, which is included as a dependency to this library. The following code will read the stops from the database:
```swift
    import GtfsDb
    import GRDB

    func fetchStops() async throws -> [Stop] {
        let dbPath = "path/to/your/database.sqlite"
        var config = Configuration()
        config.readonly = true
        dbQueue = try DatabaseQueue(path: dbPath, configuration: config)
        let stops = try await dbQueue.read { db in try Stop.fetchAll(db) }
        return stops
    }
```
 