//
//  PowerstatsView.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/19.
//

import UIKit

@IBDesignable
final class PowerstatsView: UIView {
    
    @IBOutlet private weak var strengthLabel: UILabel!
    @IBOutlet private weak var combatLabel: UILabel!
    @IBOutlet private weak var intelligenceLabel: UILabel!
    @IBOutlet private weak var durabilityLabel: UILabel!
    @IBOutlet private weak var powerLabel: UILabel!
    @IBOutlet private weak var speedLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "PowerstatsView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(pStat: Powerstats) {
        intelligenceLabel.text = pStat.intelligence
        durabilityLabel.text = pStat.durability
        strengthLabel.text = pStat.strength
        combatLabel.text = pStat.combat
        powerLabel.text = pStat.power
        speedLabel.text = pStat.speed
    }
}
