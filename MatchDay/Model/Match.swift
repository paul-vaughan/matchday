//
//  Match.swift
//  MatchDay
//
//  Created by Paul Vaughan on 29/05/2023.
//

import Foundation

struct Match: Decodable {
    var matchId: Int?
    var federationMatchNumber: Int?
    var homeTeam: MatchTeam
    var awayTeam: MatchTeam
    var matchTime: Date

    enum CodingKeys: String, CodingKey {
        case matchId = "match_id"
        case federationMatchNumber = "federation_match_number"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case matchTime = "match_time"
    }
}
