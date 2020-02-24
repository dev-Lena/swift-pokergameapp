//
//  ViewController.swift
//  CardGameApp
//
//  Created by Keunna Lee on 2020/02/08.
//  Copyright © 2020 Keunna Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var gameMode = GameMode.fiveCardStud
    private var numbersOfPlayers = NumbersOfPlayers.four
    private var pokerGame = PokerGame(numbersOfPlayers: .four, gameMode: .fiveCardStud)
   
    // MARK: - Properties
    // StackView
    func makeCardsStackView() -> UIStackView {
        let horizontalStackView = UIStackView()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = -5
        return horizontalStackView
    }
    
    // 참여한 플레이어들의 카드가 쌓이는 StackView
    func makePlayersStackView() ->  UIStackView {
        let playersCardsStackView = UIStackView()
        playersCardsStackView.translatesAutoresizingMaskIntoConstraints = false
        playersCardsStackView.axis = .vertical
        playersCardsStackView.distribution = .fillEqually
        playersCardsStackView.spacing = 4
        
        return playersCardsStackView
    }
    
    let gameStackView : UIStackView = {
           let gameStackView = UIStackView()
           gameStackView.translatesAutoresizingMaskIntoConstraints = false
           gameStackView.axis = .vertical
           gameStackView.distribution = .fillEqually
           gameStackView.alignment = .fill
           gameStackView.spacing = 0
           return gameStackView
       }()
    
    // SegmentedControl
    // - GameMode
    let gameModes: [String] = ["7 Cards", "5 Cards"]
    
    lazy var gameModeSegmentControl: UISegmentedControl = {
        let gameModeSegmentControl: UISegmentedControl = UISegmentedControl(items: gameModes)
        
        gameModeSegmentControl.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/12)
        gameModeSegmentControl.backgroundColor = UIColor.gray
        gameModeSegmentControl.tintColor = UIColor.white
        gameModeSegmentControl.addTarget(self, action:
            #selector(gameModeSegmentChanged(segmentedControl:)),
                                         for: .valueChanged)
        gameModeSegmentControl.selectedSegmentIndex = 0
        return gameModeSegmentControl
    }()
    
    // - Players
    let numbersOfPlayersList: [String] = ["2명", "3명", "4명"]
    
    lazy var numbersOfPlayersSegmentControl: UISegmentedControl = {
        let numbersOfPlayersSegmentControl: UISegmentedControl = UISegmentedControl(items: numbersOfPlayersList)
        numbersOfPlayersSegmentControl.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/7-10)
        numbersOfPlayersSegmentControl.backgroundColor = UIColor.gray
        numbersOfPlayersSegmentControl.tintColor = UIColor.white
        numbersOfPlayersSegmentControl.addTarget(self, action:
            #selector(numbersOfPlayersSegmentChanged(segmentedControl:)),
                                                 for: .valueChanged)
        numbersOfPlayersSegmentControl.selectedSegmentIndex = 0
        return numbersOfPlayersSegmentControl
        
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage:  #imageLiteral(resourceName: "bg_pattern"))
        
        //UISegmentedControl - 게임 모드 선택
        self.view.addSubview(self.gameModeSegmentControl)
        //UISegmentedControl - 플레이어 인원 선택
        self.view.addSubview(self.numbersOfPlayersSegmentControl)
        
        pokerGame.start() // 게임 시작 : 카드 셔플 후 분배
//        pokerGame.forEachPlayer(behavior: ){ (player) in
//            print(player.cardsInHand.count)
//        }
        var playersStack = makePlayersStackView()

        var playerNumber = 1
        numbersOfPlayers.setPlayerSeat{ // 4명
            pokerGame.shuffleWholeCardDeck()
            // playersStack에 UILabel을 subView로 추가하기
            playersStack.addArrangedSubview(makePlayersLabel(of: "Player\(playerNumber)"))
            playersStack.addArrangedSubview(makePlayersCardsStack())
            
            self.view.addSubview(playersStack)
            setStackView(of: playersStack)
            playerNumber += 1
        }
      
        //딜러 추가
        playersStack.addArrangedSubview (makePlayersLabel(of: "Dealer"))
        playersStack.addArrangedSubview(makeDealerCardsStack())
        //gameStackView - 딜러와 플레이어들을 담고 있는 StackView에 추가
        gameStackView.addArrangedSubview(playersStack)
        self.view.addSubview(gameStackView)
        setStackView(of: gameStackView)
    }
    
    func makePlayersLabel(of player: String) -> UILabel{
        var participantLabel = UILabel()
        participantLabel.text = "\(player)"
        participantLabel.textColor = .white
        return participantLabel
    }
    
    func makePlayersCardsStack() -> UIStackView {
        let playerCardStack = makeCardsStackView()
        addPlayersCards(of: playerCardStack)
        return playerCardStack
    }
    
    func addPlayersCards(of stackView: UIStackView) {
        
        pokerGame.forEachPlayer(behavior: ){
            player in
            // 여기서 여러번 추가 됨. // 여기가 문제임.
//            print(player.cardsInHand.count)
//            print("얏")
        print("ViewController에서 addPlayersCards 에서 pokerGame.forEachPlayer(behavior: )하고 player.cardsInHand.count :  \(player.cardsInHand.count)")
            for card in player.cardsInHand {
//            player.showEachCardInHand(behavior: ){
//                (card) in
                let cardImage = UIImageView(image: UIImage(named: card.description))
                // 카드 이미지 세팅
                cardImage.contentMode = .scaleAspectFit
                cardImage.heightAnchor.constraint(equalTo: cardImage.widthAnchor, multiplier: 1.27).isActive = true
                stackView.addArrangedSubview(cardImage)
            }
        }
    }
    
    func makeDealerCardsStack() -> UIStackView {
           let dealerCardStack = makeCardsStackView()
           addDealerCards(of: dealerCardStack)
           return dealerCardStack
       }
    
    func addDealerCards(of stackView: UIStackView) {
        pokerGame.showDealerCards(behavior: ){ card in
            let cardImage = UIImageView(image: UIImage(named: card.description))
            // 카드 이미지 세팅
            cardImage.contentMode = .scaleAspectFit
            cardImage.heightAnchor.constraint(equalTo: cardImage.widthAnchor, multiplier: 1.27).isActive = true
            stackView.addArrangedSubview(cardImage)
        }
    }
    
    // MARK: - Configuration
    // StackView
    func setStackView(of stackView : UIStackView) {
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 140).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true
    }
    
    // StackView에 넣을 이미지 뷰 생성
    func makeCard() -> UIImageView {
        let card = UIImageView(image:  #imageLiteral(resourceName: "card-back"))
        card.contentMode = .scaleAspectFit
        card.heightAnchor.constraint(equalTo: card.widthAnchor, multiplier: 1.27).isActive = true
        return card
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // SegmentedControl
    @objc func gameModeSegmentChanged(segmentedControl: UISegmentedControl){
        // 게임 모드 선택에 따른 내용 구현 예정
        switch segmentedControl.selectedSegmentIndex {
        //        case 0: // 5 cards
        //        case 1: // 7 cards
        default: return
        }
    }
    
    @objc func numbersOfPlayersSegmentChanged(segmentedControl: UISegmentedControl){
        // 플레이어 인원 선택에 따른 내용 구현 예정
        switch segmentedControl.selectedSegmentIndex {
//        case 0: startPokerGame()// 2 명
//        case 1: startPokerGame()// 3 명
//        case 2: startPokerGame()// 4 명
        default: return
        }
    }
    
    func setSegmentedControl() {
        // 추후 추가 예정
    }
}





