//
//  GameViewModelDelegate.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/12.
//

import Foundation

protocol GameViewModelDelegate: AnyObject {
    func refreshViewContents()
    func showUnlockHeroAlert(with name: String, with publisher: String)
    func showErrorMessage(error: Error)
}
