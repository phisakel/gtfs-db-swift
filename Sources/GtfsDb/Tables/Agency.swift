import Foundation
import GRDB
@preconcurrency import GTFS

extension Agency: @retroactive @unchecked Sendable, @retroactive FetchableRecord, @retroactive TableRecord {
    public static var databaseTableName: String { "agency" }
    public static let databaseColumnDecodingStrategy = DatabaseColumnDecodingStrategy.convertFromSnakeCase
}
