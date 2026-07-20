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

  /// Deletes the GTFS database at the specified path, including SQLite sidecar files.
  ///
  /// Removes the main database file along with the `-wal` and `-shm` files that SQLite
  /// may create next to it. Missing files are skipped. Make sure no DatabaseQueue is
  /// still using the database before calling this.
  ///
  /// - Parameter path: The file path of the database to delete
  /// - Throws: An error if an existing file cannot be removed
  public static func deleteDatabase(at path: String) throws {
    let fileManager = FileManager.default
    for suffix in ["", "-wal", "-shm"] {
      let filePath = path + suffix
      if fileManager.fileExists(atPath: filePath) {
        try fileManager.removeItem(atPath: filePath)
      }
    }
  }
}
