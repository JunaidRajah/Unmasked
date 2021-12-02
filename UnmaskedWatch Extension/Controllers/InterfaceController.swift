//
//  InterfaceController.swift
//  UnmaskedWatch Extension
//
//  Created by Junaid Rajah on 2021/11/30.
//

import WatchKit
import UIKit
import Foundation
import WatchConnectivity

public var heroOneName = "Loading"
public var heroTwoName = "Loading"
public var heroOneImageURL = ""
public var heroTwoImageURL = ""
public var currentHeroOneImageURL = ""
public var currentHeroTwoImageURL = ""
public var isHeroImageOne = false

class InterfaceController: WKInterfaceController {
    
    @IBOutlet private weak var statLabel: WKInterfaceLabel!
    @IBOutlet private weak var scoreLabel: WKInterfaceLabel!
    @IBOutlet private weak var connectGroup: WKInterfaceGroup!
    
    private let session = WCSession.default
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        session.delegate = self
        session.activate()
        becomeCurrentPage()
    }
}

extension InterfaceController: WCSessionDelegate {

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession,
                 didReceiveMessage message: [String : Any]) {
        handleSession(session,
                      didReceiveMessage: message)
    }

    func session(_ session: WCSession,
                 didReceiveMessage message: [String : Any],
                 replyHandler: @escaping ([String : Any]) -> Void) {
        handleSession(session,
                      didReceiveMessage: message,
                      replyHandler: replyHandler)
    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        if WCSession.default.isReachable {
            connectGroup.setHidden(true)
        } else {
            connectGroup.setHidden(false)
        }
    }
    
    func handleSession(_ session: WCSession,
                       didReceiveMessage message: [String : Any],
                       replyHandler: (([String : Any]) -> Void)? = nil) {
        connectGroup.setHidden(true)
        if let stat = message["Stat"] as? String {//**7.1
            self.statLabel.setText(stat)
        }

        if let currentScore = message["currentScore"] as? String {//**7.1
            self.scoreLabel.setText("\(currentScore)")
        }
        
        if let heroOneLabel = message["HeroOneName"] as? String {
            heroOneName = heroOneLabel
        }
        
        if let heroTwoLabel = message["HeroTwoName"] as? String {
            heroTwoName = heroTwoLabel
        }
        
        if let heroOneImgURL = message["HeroOneImageURL"] as? String {
            heroOneImageURL = heroOneImgURL
        }
        
        if let heroTwoImgURL = message["HeroTwoImageURL"] as? String {
            heroTwoImageURL = heroTwoImgURL
        }
        
        if let appClose = message["Close"] as? Bool {
            if appClose == true {
                connectGroup.setHidden(false)
            }
        }
        becomeCurrentPage()
    }
}
