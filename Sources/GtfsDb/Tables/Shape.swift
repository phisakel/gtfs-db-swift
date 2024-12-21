import Foundation
import GRDB
@preconcurrency import GTFS

extension Shape: @retroactive @unchecked Sendable, @retroactive FetchableRecord, @retroactive TableRecord {
    public static var databaseTableName: String { "shapes" }
    public static let databaseColumnDecodingStrategy = DatabaseColumnDecodingStrategy.convertFromSnakeCase
}
