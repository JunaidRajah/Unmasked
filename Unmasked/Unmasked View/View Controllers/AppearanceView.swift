//
//  AppearanceView.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/19.
//


import UIKit

final class AppearanceView: UIView {
    
    
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var raceLabel: UILabel!
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var eyeLabel: UILabel!
    @IBOutlet private weak var hairLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "AppearanceView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(appear: Appearance) {
        genderLabel.text = appear.gender
        raceLabel.text = appear.race
        heightLabel.text = appear.height[0]
        weightLabel.text = appear.weight[1]
        eyeLabel.text = appear.eyeColor
        hairLabel.text = appear.hairColor
    }
}
