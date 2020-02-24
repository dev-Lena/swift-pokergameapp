//
//  PokerGame.swift
//  CardGameApp
//
//  Created by Keunna Lee on 2020/02/14.
//  Copyright © 2020 Keunna Lee. All rights reserved.
//

import Foundation

enum NumbersOfPlayers : Int {
    case one = 1 , two, three, four
    
    // 플레이어의 자리가 몇 개가 필요한지 세팅
    func setPlayerSeat(for behavior: () -> ()) {
        for _ in 1 ... self.rawValue {
            behavior()
        }
    }
}

enum GameMode : Int {
    case fiveCardStud = 5
    case sevenCardStud = 7
    
    func compareStudNumber(with target : Int) -> Bool {
        return self.rawValue == target
    }
    
    // 카드를 내려놓는 곳이 몇 개가 필요한지 세팅
    func setCardPlacement(of behavior: ()-> ()) {
        for _ in 1 ... self.rawValue{
            behavior()
        }
    }
}

class PokerGame {
    
    private let gameMode: GameMode
    private let dealer = Dealer()
    private let numbersOfPlayers : NumbersOfPlayers
    private var players = Players(with: nil)
    
    init(numbersOfPlayers: NumbersOfPlayers, gameMode: GameMode) {
        self.gameMode = gameMode
        self.numbersOfPlayers = numbersOfPlayers
        self.players = Players(with: numbersOfPlayers)
    }
    
    func start() {
        // 카드 분배
        gameMode.setCardPlacement {
            distributeCards()
            }
    }
    
    private func distributeCards() {
        players.addCard(newCard: dealer.giveOneCard())
        dealer.addCard(newCard: dealer.giveOneCard())
    }
    
    func shuffleWholeCardDeck(){
        dealer.shuffleCardDeck()
    }
    
    func forEachPlayer(behavior: (Player) -> ()) {
        players.showParticipantsCards(behavior: ) { (player) in
            behavior(player)
        }
    }
    
}
