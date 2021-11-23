//
//  InfoElementView.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/19.
//

import UIKit

final class InfoElementView: UIView {
    
    @IBOutlet private weak var elementLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "InfoElementView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(element: String) {
        elementLabel.text = element
    }
}
