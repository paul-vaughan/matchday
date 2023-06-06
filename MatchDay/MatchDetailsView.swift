//
//  MatchDetailsView.swift
//  MatchDay
//
//  Created by Paul Vaughan on 31/05/2023.
//

import SwiftUI

struct MatchDetailsView: View {
    var game: MatchDetails
    var onSelect: (_ game: MatchDetails) -> Void

    var startTime: String {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "HH:mm"
        return formatter3.string(from: game.startTime)
    }

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.5)) {
                onSelect(game)
            }
        }) {
            VStack(spacing: .zero){
                HStack {
                    Text(game.teamName?.replacingOccurrences(of: "CKMF2", with: "Livia")
                        .replacingOccurrences(of: "Meisjes", with: "Hannah") ?? "")
                    .font(.headline)
                    Text(game.isHomeGame ?? true ? "- Thuis" : "- Uit")
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            if let url = game.homeTeam?.clubLogoUrl {
                                AsyncImage(
                                    url: URL(string: url),
                                    content: { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 24.0, maxHeight: 24.0)
                                    },
                                    placeholder: {
                                        EmptyView()
                                    }
                                )
                            }
                            Text(game.homeTeam?.clubName ?? "")
                                .font(.body)
                        }

                        HStack {
                            if let url = game.awayTeam?.clubLogoUrl {
                                AsyncImage(
                                    url: URL(string: url),
                                    content: { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 24.0, maxHeight: 24.0)
                                    },
                                    placeholder: {
                                        EmptyView()
                                    }
                                )
                            }
                            Text(game.awayTeam?.clubName ?? "")
                                .font(.body)
                        }
                    }
                    Spacer()
                    VStack {
                        Text(startTime)
                            .font(.headline)
                        Text(game.pitch?.name ?? "")
                            .font(.subheadline)
                    }
                    .padding(16.0)
                    .border(width: 0.5, edges: [.leading], color: Color.gray)

                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
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

//struct MatchDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MatchDetailsView()
//    }
//}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return width
                case .leading, .trailing: return rect.height
                }
            }
            path.addRect(CGRect(x: x, y: y, width: w, height: h))
        }
        return path
    }
}
