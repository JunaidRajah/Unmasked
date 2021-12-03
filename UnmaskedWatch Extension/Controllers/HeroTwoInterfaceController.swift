//
//  HeroTwoInterfaceController.swift
//  UnmaskedWatch Extension
//
//  Created by Junaid Rajah on 2021/12/01.
//

import WatchKit
import Foundation
import WatchConnectivity

class HeroTwoInterfaceController: WKInterfaceController {
    
    @IBOutlet private weak var option2Button: WKInterfaceButton!
    @IBOutlet private weak var heroTwoImage: WKInterfaceImage!
    @IBOutlet private weak var heroTwoLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        heroTwoLabel.setText(heroTwoName)
        if currentHeroTwoImageURL != heroTwoImageURL {
            heroTwoImage.loadImage(with: heroTwoImageURL)
            currentHeroTwoImageURL = heroTwoImageURL
        }
    }
    
    @IBAction func pressedOption2Button() {
        let data: [String: Any] = ["isHeroOne": false as Bool]
        WCSession.default.sendMessage(data, replyHandler: nil, errorHandler: nil)
    }
}
