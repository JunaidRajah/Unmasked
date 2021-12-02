//
//  HeroOneInterfaceController.swift
//  UnmaskedWatch Extension
//
//  Created by Junaid Rajah on 2021/12/01.
//

import WatchKit
import Foundation
import WatchConnectivity

class HeroOneInterfaceController: WKInterfaceController {

    @IBOutlet private weak var option1Button: WKInterfaceButton!
    @IBOutlet private weak var heroOneImage: WKInterfaceImage!
    @IBOutlet private weak var heroOneLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        heroOneLabel.setText(heroOneName)
        if currentHeroOneImageURL != heroOneImageURL {
            heroOneImage.loadImage(with: heroOneImageURL)
            currentHeroOneImageURL = heroOneImageURL
        }
    }

    @IBAction func pressedOption1Button() {
        print("sending message")
        let data: [String: Any] = ["isHeroOne": true as Bool]
        WCSession.default.sendMessage(data, replyHandler: nil, errorHandler: nil)
    }
}
