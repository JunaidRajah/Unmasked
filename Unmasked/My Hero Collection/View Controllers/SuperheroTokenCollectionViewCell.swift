//
//  SuperheroTokenCollectionViewCell.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/07.
//

import UIKit

class SuperheroTokenCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var superheroImage: UIImageView!
    @IBOutlet private weak var superheroNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with hero: SuperheroResponseModel) {
        print("reached nib")
        if let url = URL(string: hero.image.url) {
            superheroImage.load(url: url)
        }
        superheroNameLabel.text = hero.name
    }

}
