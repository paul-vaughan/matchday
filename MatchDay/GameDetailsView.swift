//
//  GameDetailsView.swift
//  MatchDay
//
//  Created by Paul Vaughan on 31/05/2023.
//

import SwiftUI

struct Game: Identifiable {
    let id = UUID()
    let date: String
    let opponent: String
    let location: String
    let time: String
    let description: String
}

struct GameListItem: View {

    var game: Game
    var onSelect: (_ game: Game) -> Void

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.5)) {
                onSelect(game)
            }
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(game.date)
                        .font(.subheadline)
                    Text(game.opponent)
                        .font(.headline)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(8)
            //.shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
        }
        .padding(.vertical, 8)
        .buttonStyle(PlainButtonStyle())
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

struct GameView: View {
    @State private var selectedGame: Game?
    @State private var isAnimating = false
    @State private var matches: [MatchDetails] = []

    var matchesGroupedByDate: [String: [MatchDetails]] {
        Dictionary(grouping: matches) {
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "d MMM y"
            return formatter3.string(from:  $0.startTime)
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(matchesGroupedByDate.sorted(by: { $0.value.first?.startTime ?? Date() < $1.value.first?.startTime ?? Date()}), id: \.key) { section in
                    Section(header: Text(section.key).font(.headline)) {
                        ForEach(section.value) { game in
                            MatchDetailsView(game: game) { selected in
                                isAnimating = true
                                //selectedGame = selected
                            }
                        }
                    }.listRowInsets(EdgeInsets())
                }
            }
            .navigationBarTitle("Game Schedule")
        }
        .onAppear(perform: loadGames)
        .sheet(item: $selectedGame) { game in
            GameDetailsView(game: game)
                .transition(.move(edge: .leading))
                .animation(.easeInOut(duration: 0.5))
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isAnimating = false
                    }
                }
        }
    }



    func loadGames() {
        Task {
            let api = HockeyAppApi()

            do {
                let teams = try await api.loadMyTreams()
                for team in teams {
                    if let id = team.teamId {
                        let games = try await api.loadPoolSchedule(for: id)
                        for game in games {
                            if let gameId = game.matchId {
                                if var details = try await api.loadMatchDetails(for: gameId) {
                                    details.updateTeam(name: team.name)
                                    matches.append(details)
                                }
                            }
                        }
                    }
                }
//
//                if let id = teams.first?.teamId {
//                    var games = try await api.loadPoolSchedule(for: id)
//                    print(games?.homeTeam.teamName)
//
//                    if let gameId = games?.matchId {
//                        var details = try await api.loadMatchDetails(for: gameId)
//                        print(details?.homeTeam.clubLogoUrl)
//                    }
//                }
            } catch {
                print(error)
                //self.error = error
                //self.showingAlert = true
            }
        }
    }


}

struct GameDetailsView: View {
    let game: Game

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Date: \(game.date)")
                .font(.headline)
            Text("Opponent: \(game.opponent)")
                .font(.subheadline)
            Text("Location: \(game.location)")
                .font(.subheadline)
            Text("Time: \(game.time)")
                .font(.subheadline)
            Text(game.description)
                .font(.body)

            Spacer()
        }
        .padding()
        .navigationBarTitle("Game Details", displayMode: .inline)
    }
}
