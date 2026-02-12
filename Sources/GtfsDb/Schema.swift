import Dependencies
import Foundation
import GRDB

func makeMigrator() -> DatabaseMigrator {
  var migrator = DatabaseMigrator()
  #if DEBUG
    migrator.eraseDatabaseOnSchemaChange = true
  #endif

  // GTFS Schema Migrations
  migrator.registerMigration("v1") { db in
    // Agency table
    try db.create(table: "agency") { t in
      t.column("agency_id", .text)
      t.column("agency_name", .text).notNull()
      t.column("agency_url", .text).notNull()
      t.column("agency_timezone", .text).notNull()
      t.column("agency_lang", .text)
      t.column("agency_phone", .text)
      t.column("agency_fare_url", .text)
      t.column("agency_email", .text)
    }

    // Stops table
    try db.create(table: "stops") { t in
      t.column("stop_id", .text).primaryKey()
      t.column("stop_code", .text)
      t.column("stop_name", .text)
      t.column("stop_desc", .text)
      t.column("stop_lat", .double)
      t.column("stop_lon", .double)
      t.column("zone_id", .text)
      t.column("stop_url", .text)
      t.column("location_type", .integer)
      t.column("parent_station", .text)
      t.column("stop_timezone", .text)
      t.column("wheelchair_boarding", .integer)
      t.column("level_id", .text)
      t.column("platform_code", .text)
    }

    // Routes table
    try db.create(table: "routes") { t in
      t.column("route_id", .text).primaryKey()
      t.column("agency_id", .text)
      t.column("route_short_name", .text)
      t.column("route_long_name", .text)
      t.column("route_desc", .text)
      t.column("route_type", .integer).notNull()
      t.column("route_url", .text)
      t.column("route_color", .text)
      t.column("route_text_color", .text)
      t.column("route_sort_order", .integer)
      t.column("continuous_pickup", .integer)
      t.column("continuous_drop_off", .integer)
    }

    // Trips table
    try db.create(table: "trips") { t in
      t.column("trip_id", .text).primaryKey()
      t.column("route_id", .text).notNull()
      t.column("service_id", .text).notNull()
      t.column("trip_headsign", .text)
      t.column("trip_short_name", .text)
      t.column("direction_id", .integer)
      t.column("block_id", .text)
      t.column("shape_id", .text)
      t.column("wheelchair_accessible", .integer)
      t.column("bikes_allowed", .integer)
    }

    // Stop Times table
    try db.create(table: "stop_times") { t in
      t.column("trip_id", .text).notNull()
      t.column("arrival_time", .text)
      t.column("departure_time", .text)
      t.column("stop_id", .text).notNull()
      t.column("stop_sequence", .integer).notNull()
      t.column("stop_headsign", .text)
      t.column("pickup_type", .integer)
      t.column("drop_off_type", .integer)
      t.column("continuous_pickup", .integer)
      t.column("continuous_drop_off", .integer)
      t.column("shape_dist_traveled", .double)
      t.column("timepoint", .integer)
    }

    // Calendar table
    try db.create(table: "calendar") { t in
      t.column("service_id", .text).primaryKey()
      t.column("monday", .integer).notNull()
      t.column("tuesday", .integer).notNull()
      t.column("wednesday", .integer).notNull()
      t.column("thursday", .integer).notNull()
      t.column("friday", .integer).notNull()
      t.column("saturday", .integer).notNull()
      t.column("sunday", .integer).notNull()
      t.column("start_date", .text).notNull()
      t.column("end_date", .text).notNull()
    }

    // Calendar Dates table
    try db.create(table: "calendar_dates") { t in
      t.column("service_id", .text).notNull()
      t.column("date", .text).notNull()
      t.column("exception_type", .integer).notNull()
    }

    // Fare Rules table
    try db.create(table: "fare_rules") { t in
      t.column("fare_id", .text).notNull()
      t.column("route_id", .text)
      t.column("origin_id", .text)
      t.column("destination_id", .text)
      t.column("contains_id", .text)
    }

    // Shapes table
    try db.create(table: "shapes") { t in
      t.column("shape_id", .text).notNull()
      t.column("shape_pt_lat", .double).notNull()
      t.column("shape_pt_lon", .double).notNull()
      t.column("shape_pt_sequence", .integer).notNull()
      t.column("shape_dist_traveled", .double)
    }

    // Frequencies table
    try db.create(table: "frequencies") { t in
      t.column("trip_id", .text).notNull()
      t.column("start_time", .text).notNull()
      t.column("end_time", .text).notNull()
      t.column("headway_secs", .integer).notNull()
      t.column("exact_times", .integer)
    }

    // Transfers table
    try db.create(table: "transfers") { t in
      t.column("from_stop_id", .text).notNull()
      t.column("to_stop_id", .text).notNull()
      t.column("transfer_type", .integer).notNull()
      t.column("min_transfer_time", .integer)
    }

    // Pathways table
    try db.create(table: "pathways") { t in
      t.column("pathway_id", .text).primaryKey()
      t.column("from_stop_id", .text).notNull()
      t.column("to_stop_id", .text).notNull()
      t.column("pathway_mode", .integer).notNull()
      t.column("is_bidirectional", .integer).notNull()
      t.column("length", .double)
      t.column("traversal_time", .integer)
      t.column("stair_count", .integer)
      t.column("max_slope", .double)
      t.column("min_width", .double)
      t.column("signposted_as", .text)
      t.column("reversed_signposted_as", .text)
    }

    // Feed Info table
    try db.create(table: "feed_info") { t in
      t.column("feed_publisher_name", .text).notNull()
      t.column("feed_publisher_url", .text).notNull()
      t.column("feed_lang", .text).notNull()
      t.column("default_lang", .text)
      t.column("feed_start_date", .text)
      t.column("feed_end_date", .text)
      t.column("feed_version", .text)
      t.column("feed_contact_email", .text)
      t.column("feed_contact_url", .text)
    }

    // Translations table
    try db.create(table: "translations") { t in
      t.column("table_name", .text).notNull()
      t.column("field_name", .text).notNull()
      t.column("language", .text).notNull()
      t.column("translation", .text).notNull()
      t.column("record_id", .text)
      t.column("record_sub_id", .text)
      t.column("field_value", .text)
    }

    // Attributions table
    try db.create(table: "attributions") { t in
      t.column("attribution_id", .text)
      t.column("agency_id", .text)
      t.column("route_id", .text)
      t.column("trip_id", .text)
      t.column("organization_name", .text).notNull()
      t.column("is_producer", .integer)
      t.column("is_operator", .integer)
      t.column("is_authority", .integer)
      t.column("attribution_url", .text)
      t.column("attribution_email", .text)
      t.column("attribution_phone", .text)
    }
  }

  return migrator
}


