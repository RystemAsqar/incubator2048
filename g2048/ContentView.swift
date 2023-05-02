//
//  ContentView.swift
//  g2048
//
//  Created by Rystem Asqar on 4/30/23.
//

import SwiftUI

struct Tile: Identifiable {
    let id: Int
    var value: Int
}

struct ContentView: View {
    var body: some View {
        let game = GameLogic()
        NavigationView {
            ZStack {
                Image("back1")
                    .resizable()
                    .overlay(content: {
                        LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                    })
                VStack {
                    Spacer()
                    Text("Welcome to the \n2048")
                        .font(.system(size: 45, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    
                    NavigationLink(destination: GameView(game: game, id: 0)) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .shadow(radius: 10)
                                .frame(width: 200, height: 40)
                            Text("Play with Bot")
                                .foregroundColor(.black)
                                .bold()
                        }
                    }
                    NavigationLink(destination: GameView(game: game, id: 1)) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .shadow(radius: 10)
                                .frame(width: 200, height: 40)
                            Text("Play as Guest")
                                .foregroundColor(.black)
                                .bold()
                                .onAppear{
                                    game.reset()
                                }
                        }
                    }
                    .padding(.bottom, 90)
                }
            }
            .ignoresSafeArea()
        }
    }
}


struct TileView: View {
    let value: Int
    
    var body: some View {
        ZStack{
            let col = TileColor.color(self.value)
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(col.backgroundColor)
            Text(value == 0 ? "" : "\(value)")
                .foregroundColor(value>7 ?.white: .black)
                .bold()
                .font(.title)
        }
        .frame(width: 66, height: 66)
    }
}

enum Direc: String, CaseIterable{
    case up = "up"
    case down = "down"
    case left = "left"
    case right = "right"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum TileColor {
    case none
    case color(Int)
    
    var backgroundColor: Color {
        switch self {
        case .none:
            return Color.gray.opacity(0.2)
        case .color(let value):
            switch value {
            case 2:
                return Color(red: 238/255, green: 228/255, blue: 218/255)
            case 4:
                return Color(red: 237/255, green: 224/255, blue: 200/255)
            case 8:
                return Color(red: 242/255, green: 177/255, blue: 121/255)
            case 16:
                return Color(red: 245/255, green: 149/255, blue: 99/255)
            case 32:
                return Color(red: 246/255, green: 124/255, blue: 95/255)
            case 64:
                return Color(red: 246/255, green: 94/255, blue: 59/255)
            case 128, 256, 512, 1024, 2048:
                return Color(red: 237/255, green: 207/255, blue: 114/255)
            default:
                return Color(red: 205/255, green: 193/255, blue: 181/255)
            }
        }
    }
}

