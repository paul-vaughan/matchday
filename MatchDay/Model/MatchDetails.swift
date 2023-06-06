//
//  MatchDetails.swift
//  MatchDay
//
//  Created by Paul Vaughan on 30/05/2023.
//

import Foundation

struct MatchDetails: Codable, Identifiable {
    var id: Int
    var teamId: Int
    var teamName: String?
    var poolName: String?
    var isHomeGame: Bool?
    var startTime: Date
    var meetingTime: Date?
    var alternateKit: Bool?
    var homeTeam: MDTeam?
    var awayTeam: MDTeam?
    var pitch: Pitch?
    var venue: Venue?

    enum CodingKeys: String, CodingKey {
        case id
        case teamId = "team_id"
        case teamName
        case poolName = "pool_name"
        case isHomeGame = "is_home"
        case startTime  = "starts_at"
        case meetingTime = "meeting_time"
        case alternateKit = "alternate_kit"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case pitch
        case venue = "location"
    }

    mutating func updateTeam(name: String) {
        self.teamName = name
    }
}

struct Pitch: Codable {
    var name: String
    var type: String

    enum CodingKeys: CodingKey {
        case name
        case type
    }
}

struct Venue: Codable {
    var name: String
    var adress: Adress?
}

struct Adress: Codable {
    var street: String?
    var houseNumber: String?
    var houseNumberExtension: String?
    var zipCode: String?
    var city: String?
    var location: GeoLocation?

    enum CodingKeys: String, CodingKey {
        case street
        case houseNumber = "house_number"
        case houseNumberExtension = "house_number_extension"
        case zipCode = "zipcode"
        case city
        case location = "geo"
    }
}

struct GeoLocation: Codable {
    var latitude: CGFloat
    var longitude: CGFloat
}

struct MDTeam: Codable {
    var clubName: String?
    var clubLogoUrl: String?
    var clubFederationCode: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case clubName = "club_name"
        case clubLogoUrl = "club_logo_url"
        case clubFederationCode = "club_federation_code"
        case name
    }
}
