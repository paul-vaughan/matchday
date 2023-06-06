//
//  ContentView.swift
//  MatchDay
//
//  Created by Paul Vaughan on 29/05/2023.
//

import SwiftUI

struct ContentView: View {

    let api = HockeyAppApi()
    @State var teams: [Team] = []
    @State var error: Error?

    @State var showingAlert = false

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            if let team = teams.first?.name {
                Text(team)
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("error"), message: Text(error?.localizedDescription ?? ""), dismissButton: .cancel())
        }
        .padding()
//        .onAppear{
//            Task {
//                do {
//                    teams = try await api.loadMyTreams()
//                    if let id = teams.first?.teamId {
//                        var games = try await api.loadPoolSchedule(for: id)
//                        print(games?.homeTeam.teamName)
//
//                        if let gameId = games?.matchId {
//                            var details = try await api.loadMatchDetails(for: gameId)
//                            print(details?.homeTeam.clubLogoUrl)
//                        }
//                    }
//                } catch {
//                    self.error = error
//                    self.showingAlert = true
//                }
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
