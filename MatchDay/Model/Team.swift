//
//  Team.swift
//  MatchDay
//
//  Created by Paul Vaughan on 29/05/2023.
//

import Foundation

struct Team: Decodable, Identifiable {
    var id: Int {
        teamId ?? federationTeamId ?? -1
    }

    var teamId: Int?
    var federationTeamId: Int?
    var name: String
    var abbreviation: String
    var gender: String
    var showRoster: Bool

    enum CodingKeys: String, CodingKey {
        case teamId = "id"
        case federationTeamId = "federation_team_id"
        case name
        case abbreviation = "abbr_name"
        case gender = "team_gender"
        case showRoster = "show_roster"
    }
}

struct MatchTeam: Decodable, Identifiable {
    var id: Int {
        teamId ?? federationTeamId ?? -1
    }

    var teamId: Int?
    var federationTeamId: Int?
    var clubId : Int?
    var teamName : String
    var isFavouriteTeam: Bool?
    var isPersonalTeam: Bool?
    var teamNameShort : String?
    var showRoster: Bool?
    var clubNameShort : String?
    var isSelectedTeam : Bool?

    enum CodingKeys: String, CodingKey {
        case clubId = "club_id"
        case teamName = "team_name"
        case isFavouriteTeam = "is_favourite_team"
        case isPersonalTeam = "is_personal_team"
        case teamId = "team_id"
        case teamNameShort = "team_name_short"
        case showRoster = "show_roster"
        case clubNameShort = "club_name_short"
        case federationTeamId = "federation_team_id"
        case isSelectedTeam = "is_selected_team"
    }
}
