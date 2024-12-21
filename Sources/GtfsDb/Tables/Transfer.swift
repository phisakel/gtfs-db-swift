import Foundation
import GRDB
@preconcurrency import GTFS

extension Transfer: @retroactive @unchecked Sendable, @retroactive FetchableRecord, @retroactive TableRecord {
    public static var databaseTableName: String { "transfers" }
    public static let databaseColumnDecodingStrategy = DatabaseColumnDecodingStrategy.convertFromSnakeCase
}
