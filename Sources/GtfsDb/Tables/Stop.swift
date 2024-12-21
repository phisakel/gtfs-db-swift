import Foundation
import GRDB
@preconcurrency import GTFS

extension Stop: @retroactive @unchecked Sendable, @retroactive FetchableRecord, @retroactive TableRecord {
    public static var databaseTableName: String { "stops" }
    public static let databaseColumnDecodingStrategy = DatabaseColumnDecodingStrategy.convertFromSnakeCase
}
