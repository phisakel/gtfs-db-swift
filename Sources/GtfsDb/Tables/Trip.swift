import Foundation
import GRDB
@preconcurrency import GTFS

extension Trip: @retroactive @unchecked Sendable, @retroactive FetchableRecord, @retroactive TableRecord {
    public static var databaseTableName: String { "trips" }
    public static let databaseColumnDecodingStrategy = DatabaseColumnDecodingStrategy.convertFromSnakeCase
}
