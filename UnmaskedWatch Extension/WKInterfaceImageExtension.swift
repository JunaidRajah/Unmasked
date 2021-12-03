//
//  WKInterfaceImageExtension.swift
//  UnmaskedWatch Extension
//
//  Created by Junaid Rajah on 2021/12/02.
//

import Foundation
import WatchKit

@objc public extension WKInterfaceImage {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.setImage(image)
                    }
                }
            }
        }
    }
    
    @available(iOS 13.0, *)
    func loadImage(with imageURL: String) {
        if let url = URL(string: imageURL) {
            self.setImage(UIImage(named: "Unmasked1"))
            DispatchQueue.main.async {
                self.load(url: url)
            }
        }
    }
}
