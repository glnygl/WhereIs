//
//  PhotoModel.swift
//  WhereIs
//
//  Created by Glny Gl on 30.10.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.


import Foundation

struct PhotoModel: Codable {
    var meta: PhotoMeta?
    var response: PhotoResponse?
}

struct PhotoMeta: Codable {
    var code: Int?
    var requestId: String?
    
}

struct PhotoResponse: Codable {
    var photos: Photos?
}

struct Photos: Codable {
    var count: Int?
    var items: [Item]?
    var dupesRemoved: Int?
}

struct Item: Codable {
    var id: String?
    var createdAt: Int?
    var source: Source?
    var prefix: String?
    var suffix: String?
    var width, height: Int?
    var user: User?
    var checkin: Checkin?
    var visibility: String?
}

struct Checkin: Codable {
    var id: String?
    var createdAt: Int?
    var type: String?
    var timeZoneOffset: Int?
    var with: [User]?
}

struct User: Codable {
    var id, firstName, lastName, gender: String?
    var photo: Photo?
}

struct Photo: Codable {
    var prefix: String?
    var suffix: String?
}

struct Source: Codable {
    var name: String?
    var url: String?
}
