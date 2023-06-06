//
//  CompetitionRound.swift
//  MatchDay
//
//  Created by Paul Vaughan on 29/05/2023.
//

import Foundation

struct CompentionRound: Decodable {
    var date: Date
    var matches: [Match]
}
