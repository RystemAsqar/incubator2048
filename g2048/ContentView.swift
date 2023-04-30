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

class Game: ObservableObject {
    @Published var tiles: [Tile] = []
    
    init() {
        for i in 0..<16 {
            tiles.append(Tile(id: i, value: 0))
        }
        addRandomTile()
        addRandomTile()
    }
    
    func addRandomTile() {
        let emptyTiles = tiles.filter({ $0.value == 0 })
        if emptyTiles.count == 0 { return }
        let tileIndex = Int.random(in: 0..<emptyTiles.count)
        tiles[emptyTiles[tileIndex].id].value = Int.random(in: 1...2) * 2
    }
    func reset() {
        for index in 0..<16 {
            tiles[index].value = 0
        }
        addRandomTile()
        addRandomTile()
    }
    var valueSum: Int {
            var sum = 0
            for tile in tiles {
                sum += tile.value
            }
            return sum
        }
    
    
    func move(direction: String) {
        var moved = false
        switch direction {
        case "up":
            for col in 0..<4 {
                var row = 0
                while row < 3 {
                    let index = row * 4 + col
                    if tiles[index].value == 0 {
                        var nextRow = row + 1
                        while nextRow < 4 {
                            let nextIndex = nextRow * 4 + col
                            if tiles[nextIndex].value != 0 {
                                tiles[index].value = tiles[nextIndex].value
                                tiles[nextIndex].value = 0
                                moved = true
                                break
                            }
                            nextRow += 1
                        }
                    } else {
                        var nextRow = row + 1
                        while nextRow < 4 {
                            let nextIndex = nextRow * 4 + col
                            if tiles[nextIndex].value != 0 {
                                if tiles[index].value == tiles[nextIndex].value {
                                    tiles[index].value *= 2
                                    tiles[nextIndex].value = 0
                                    moved = true
                                }
                                break
                            }
                            nextRow += 1
                        }
                    }
                    row += 1
                }
            }
        case "down":
            for col in 0..<4 {
                var row = 3
                while row > 0 {
                    let index = row * 4 + col
                    if tiles[index].value == 0 {
                        var nextRow = row - 1
                        while nextRow >= 0 {
                            let nextIndex = nextRow * 4 + col
                            if tiles[nextIndex].value != 0 {
                                tiles[index].value = tiles[nextIndex].value
                                tiles[nextIndex].value = 0
                                moved = true
                                break
                            }
                            nextRow -= 1
                        }
                    } else {
                        var nextRow = row - 1
                        while nextRow >= 0 {
                            let nextIndex = nextRow * 4 + col
                            if tiles[nextIndex].value != 0 {
                                if tiles[index].value == tiles[nextIndex].value {
                                    tiles[index].value *= 2
                                    tiles[nextIndex].value = 0
                                    moved = true
                                }
                                break
                            }
                            nextRow -= 1
                        }
                    }
                    row -= 1
                }
            }
        case "left":
            for row in 0..<4 {
                var col = 0
                while col < 3 {
                    let index = row * 4 + col
                    if tiles[index].value == 0 {
                        var nextCol = col + 1
                        while nextCol < 4 {
                            let nextIndex = row * 4 + nextCol
                            if tiles[nextIndex].value != 0 {
                                tiles[index].value = tiles[nextIndex].value
                                tiles[nextIndex].value = 0
                                moved = true
                                break
                            }
                            nextCol += 1
                        }
                    } else {
                        var nextCol = col + 1
                        while nextCol < 4 {
                            let nextIndex = row * 4 + nextCol
                            if tiles[nextIndex].value != 0 {
                                if tiles[index].value == tiles[nextIndex].value {
                                    tiles[index].value *= 2
                                    tiles[nextIndex].value = 0
                                    moved = true
                                }
                                break
                            }
                            nextCol += 1
                        }
                    }
                    col += 1
                }
            }
        case "right":
            for row in 0..<4 {
                var col = 3
                while col > 0 {
                    let index = row * 4 + col
                    if tiles[index].value == 0 {
                        var nextCol = col - 1
                        while nextCol >= 0 {
                            let nextIndex = row * 4 + nextCol
                            if tiles[nextIndex].value != 0 {
                                tiles[index].value = tiles[nextIndex].value
                                tiles[nextIndex].value = 0
                                moved = true
                                break
                            }
                            nextCol -= 1
                        }
                    } else {
                        var nextCol = col - 1
                        while nextCol >= 0 {
                            let nextIndex = row * 4 + nextCol
                            if tiles[nextIndex].value != 0 {
                                if tiles[index].value == tiles[nextIndex].value {
                                    tiles[index].value *= 2
                                    tiles[nextIndex].value = 0
                                    moved = true
                                }
                                break
                            }
                            nextCol -= 1
                        }
                    }
                    col -= 1
                }
            }
        default:
            break
        }
        if moved {
            addRandomTile()
        }
    }
}

struct GameView: View {
    @ObservedObject var game: Game
    
    var body: some View {
        VStack(spacing: 10) {
            let countDict = game.valueSum
            Text("Your score: \(countDict)")
                .bold()
            Button{
                game.reset()
            }
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 188/255, green: 173/255, blue: 161/255))
                        .frame(width: 160, height: 50)
                        Text("Reset Game")
                        .foregroundColor(.black)
                        .bold()
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(red: 188/255, green: 173/255, blue: 161/255))
                    .frame(width: 335, height: 335)
                VStack(spacing: 12) {
                    ForEach(0..<4) { row in
                        HStack(spacing: 12) {
                            ForEach(0..<4) { col in
                                let tile = game.tiles[row * 4 + col]
                                TileView(value: tile.value)
                            }
                        }
                    }
                }
               
            }

            HStack(spacing: 10) {
                Button{
                    game.move(direction: "left")
                }label:{
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 188/255, green: 173/255, blue: 161/255))
                            .frame(width: 50, height: 50)
                            Text("⬅️")
                            .foregroundColor(.black)
                            .bold()
                    }
                }
                
                Button {
                    game.move(direction: "up")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 188/255, green: 173/255, blue: 161/255))
                            .frame(width: 50, height: 50)
                            Text("⬆️")
                            .foregroundColor(.black)
                            .bold()
                    }
                }
                
                Button{
                    game.move(direction: "down")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 188/255, green: 173/255, blue: 161/255))
                            .frame(width: 50, height: 50)
                            Text("⬇️")
                            .foregroundColor(.black)
                            .bold()
                    }
                }
                Button{
                    game.move(direction: "right")
                } label:{
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 188/255, green: 173/255, blue: 161/255))
                            .frame(width: 50, height: 50)
                            Text("➡️")
                            .foregroundColor(.black)
                            .bold()
                    }
                }
            }
            Button{
                let randomDirection = Direc.allCases.randomElement()?.rawValue
                game.move(direction: randomDirection!)
            } label:{
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 188/255, green: 173/255, blue: 161/255))
                        .frame(width: 90, height: 50)
                        Text("Random")
                        .foregroundColor(.black)
                        .bold()
                }
            }
            Text("The Random button makes random movements, performed like BOT")
                
            Spacer()
        }
        .padding()
        .padding(.top, 50)
        .navigationTitle("2048")
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

struct ContentView: View {
    var game = Game()
    var body: some View {
        GameView(game: game)
    }
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

