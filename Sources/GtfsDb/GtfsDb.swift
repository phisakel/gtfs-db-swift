import Dependencies
import Foundation
import GRDB

/// A library for working with GTFS (General Transit Feed Specification) data in SQLite.
///
/// This library provides:
/// - Pre-configured GTFS database schema migrations
/// - Type-safe access to GTFS data through the SQLiteData library
/// - Support for all GTFS static specification tables
///
/// ## Getting Started
///
/// 1. Call `bootstrapDatabase()` in your app's initialization:
///
/// ```swift
/// @main
/// struct MyApp: App {
///   init() {
///     prepareDependencies {
///       try! $0.bootstrapDatabase()
///     }
///   }
/// }
/// ```
///
/// 2. Access the database using the `@Dependency(\.defaultDatabase)` property wrapper:
///
/// ```swift
/// @Dependency(\.defaultDatabase) var database
///
/// let stops = try await database.read { db in
///   try Stop.fetchAll(db)
/// }
/// ```
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
