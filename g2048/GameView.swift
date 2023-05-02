//
//  Play.swift
//  g2048
//
//  Created by Rystem Asqar on 5/2/23.
//
import SwiftUI

struct GameView: View {
    @ObservedObject var game: GameLogic
    var id: Int
    
    var body: some View {
        VStack(spacing: 10) {
            let countDict = game.valueSum
            Text("Your score: \(countDict)")
                .bold()
                .font(.title)
            
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

            if id == 1 {
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
            }
            if id == 0 {
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
            }
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
            Spacer()
        }
        .padding()
        .padding(.top, 50)
        .navigationTitle("2048")
    }
}

