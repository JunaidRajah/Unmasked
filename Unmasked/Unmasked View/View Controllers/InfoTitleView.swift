//
//  InfoTitleView.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/19.
//

import UIKit

final class InfoTitleView: UIView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "InfoTitleView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }
}
