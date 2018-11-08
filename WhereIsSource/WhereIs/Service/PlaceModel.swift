//
//  PlaceModel.swift
//  WhereIs
//
//  Created by Glny Gl on 28.10.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import Foundation

struct PlaceModel: Codable {
    var meta: Meta?
    var response: Response?
}

struct Meta: Codable {
    var code: Int?
    var requestId: String?
}

struct Response: Codable {
    var suggestedFilters: SuggestedFilters?
    var geocode: Geocode?
    var headerLocation, headerFullLocation: String?
    var headerLocationGranularity: String?
    var totalResults: Int?
    var suggestedBounds: Bounds?
    var groups: [Group]?
}

struct Geocode: Codable {
    var what, geocodeWhere: String?
    var center: Center?
    var displayString: String?
    var cc: String?
    var geometry: Geometry?
    var slug, longID: String?
}
struct Center: Codable {
    var lat, lng: Double?
}

struct Geometry: Codable {
    var bounds: Bounds?
}

struct Bounds: Codable {
    var ne, sw: Center?
}

struct HereNow: Codable {
    var count: Int?
    var summary: String?
    var groups: [Group]?
}

struct Venue: Codable {
    var id, name: String?
    var contact: Contact?
    var location: Location?
    var categories: [Category]?
    var verified: Bool?
    var stats: Stats?
    var beenHere: BeenHere?
    // var photos: Photos
    var hereNow: HereNow?
    var venuePage: VenuePage?
}

struct GroupItem: Codable {
    var reasons: Reasons?
    var venue: Venue?
    var referralId: String?
}

struct Group: Codable {
    var type: String?
    var name: String?
    var items: [GroupItem]?
    var count: Int?
}

struct BeenHere: Codable {
    var count, lastCheckinExpiredAt: Int?
    var marked: Bool?
    var unconfirmedCount: Int?
}

struct Category: Codable {
    var id, name, pluralName, shortName: String?
    var icon: Icon?
    var primary: Bool?
}

struct Icon: Codable {
    var iconPrefix: String?
    var suffix: String?
}

struct Contact: Codable {
}

struct Location: Codable {
    var address: String?
    var lat, lng: Double?
    var postalCode: String?
    var cc: String?
    var neighborhood, city: String?
    var state: String?
    var country: String?
    var formattedAddress: [String]?
    var crossStreet: String?
    var labeledLatLngs: [LabeledLatLng]?
}

struct LabeledLatLng: Codable {
    var label: String?
    var lat, lng: Double?
}

//struct Photos: Codable {
//    var count: Int
//    var groups: [Any]
//}

struct Stats: Codable {
    var tipCount, usersCount, checkinsCount, visitsCount: Int?
}

struct VenuePage: Codable {
    var id: String?
}

struct Reasons: Codable {
    var count: Int?
    var items: [ReasonsItem]?
}

struct ReasonsItem: Codable {
    var summary: String?
    var type: String?
    var reasonName: String?
}

struct SuggestedFilters: Codable {
    var header: String?
    var filters: [Filter]?
}

struct Filter: Codable {
    var name, key: String?
}
