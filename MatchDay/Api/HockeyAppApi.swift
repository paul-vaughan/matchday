//
//  HockeyAppApi.swift
//  MatchDay
//
//  Created by Paul Vaughan on 29/05/2023.
//

import Foundation

struct TeamsResponse: Decodable {
    var personalTeams: [Team]
    var favouriteTeams: [Team]
    var banners: [Banner]

    enum CodingKeys: String, CodingKey {
        case personalTeams = "personal_teams"
        case favouriteTeams = "favourite_teams"
        case banners
    }
}

struct ScheduleResponse: Decodable {
    var schedule: [CompentionRound]
}

struct HockeyAppApi {
    var session = URLSession.shared
    let basicToken = ""
    let lisaToken = ""
    let basePath = "https://hockey-api-production.azurewebsites.net/api/v1.5/pub/clubs/HH11MM4"
   
    func loadMyTreams() async throws -> [Team] {
        let resp:TeamsResponse = try await loadItems(from: "/teams/my")
        return resp.personalTeams
    }

    func loadPoolSchedule(for teamdId: Int) async throws -> [Match] {
        let resp:ScheduleResponse = try await loadItems(from: "/teams/\(teamdId)/pool_schedule")
        return resp.schedule
            .compactMap({$0.matches})
            .flatMap({ $0})
            .filter({ $0.homeTeam.isSelectedTeam ?? false || $0.awayTeam.isSelectedTeam ?? false})
    }

    func loadMatchDetails(for matchId: Int) async throws -> MatchDetails? {
        return try await loadItems(from: "/matches/\(matchId)")
    }

    func loadItems<T: Decodable>(from path: String) async throws -> T {
        let url = URL(string: "\(basePath)\(path)")!
        let request = createRequest(from: url)
        let (data, _) = try await session.data(for: request)
        print(data.prettyPrintedJSONString ?? "")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    }

    func createRequest(from url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("Basic \(basicToken)", forHTTPHeaderField:  "Authorization")
        request.setValue(lisaToken, forHTTPHeaderField: "x-lisa-access-token")
        request.timeoutInterval = 20000.0
        return request
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
