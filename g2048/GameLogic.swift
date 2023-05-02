//
//  Game.swift
//  g2048
//
//  Created by Rystem Asqar on 5/2/23.
//

import Foundation

class GameLogic: ObservableObject {
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
