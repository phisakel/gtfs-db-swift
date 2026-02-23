import Foundation
import GRDB

/// A library for working with GTFS (General Transit Feed Specification) data in SQLite.
public struct GtfsDb {
  /// Creates a new GTFS database at the specified path with all required tables.
  ///
  /// - Parameter path: The file path where the database should be created
  /// - Returns: A configured DatabaseQueue ready for GTFS data
  /// - Throws: DatabaseError if the database cannot be created or migrated
  public static func createDatabase(at path: String) throws -> DatabaseQueue {
    let database = try DatabaseQueue(path: path)
    let migrator = makeMigrator()
    try migrator.migrate(database)
    return database
  }
}
