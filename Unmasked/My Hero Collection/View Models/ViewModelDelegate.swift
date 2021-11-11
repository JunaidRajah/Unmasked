//
//  ViewModelDelegate.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/07.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func refreshViewContents()
    func showErrorMessage(error: Error)
}

protocol CollectionViewModelDelegate: AnyObject {
    func refreshViewContents()
    func loadHeroFromCollection()
    func showErrorMessage(error: Error)
}
