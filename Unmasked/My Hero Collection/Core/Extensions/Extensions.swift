//
//  Extensions.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/07.
//

import Foundation
import UIKit

@objc extension UIImageView {
    func load(url: URL) {
        self.contentMode = .scaleAspectFit
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.contentMode = .scaleAspectFill
                    }
                }
            }
        }
    }
    
    func loadImage(with imageURL: String) {
        if let url = URL(string: imageURL) {
            self.image = UIImage(systemName: "arrow.clockwise")
            DispatchQueue.main.async {
                self.load(url: url)
            }
        }
    }
}

extension String {
    
    class GameViewStrings {
        func randomHeroID() -> String {
            "\(Int.random(in: 1...732))"
        }
    }
}
