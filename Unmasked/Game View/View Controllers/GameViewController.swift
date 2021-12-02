//
//  GameViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/04.
//

import UIKit
import WatchConnectivity
import UnmaskedEngine

class GameViewController: UIViewController {
    
    private lazy var gameViewModel = GameViewModel(repository: SuperheroRepository(),
                                                    delegate: self)
    
    @IBOutlet private weak var heroOneImage: UIImageView!
    @IBOutlet private weak var heroOneName: UILabel!
    @IBOutlet private weak var heroTwoImage: UIImageView!
    @IBOutlet private weak var heroTwoName: UILabel!
    @IBOutlet private weak var statLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameViewModel.activateWatchSession()
        gameViewModel.startGame()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        gameViewModel.closeWatch()
    }
    
    @IBAction func heroButtonPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            gameViewModel.heroSelected(isHeroOne: true)
        } else {
            gameViewModel.heroSelected(isHeroOne: false)
        }
    }
}

extension GameViewController: GameViewModelDelegate {
    func showUnlockHeroAlert(with name: String, with publisher: String) {
        Alert.showHeroUnlockAlert(on: self, name: name, publisher: publisher)
    }
    
    func refreshViewContents() {
        heroOneImage.contentMode = .scaleAspectFit
        heroTwoImage.contentMode = .scaleAspectFit
        
        heroOneName.text = gameViewModel.heroOneName
        heroOneImage.loadImage(with: gameViewModel.heroOneImageURL)
        heroTwoName.text = gameViewModel.heroTwoName
        heroTwoImage.loadImage(with: gameViewModel.heroTwoImageURL)
        
        statLabel.text = gameViewModel.statName
        scoreLabel.text = gameViewModel.currentScore
        gameViewModel.sendDataToWatch()
    }
    
    func showErrorMessage(error: Error) {
        Alert.showGameFailAlert(on: self)
    }
}
