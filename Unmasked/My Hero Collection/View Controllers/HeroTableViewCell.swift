//
//  HeroTableViewCell.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/08.
//

import UIKit
import UnmaskedEngine

class HeroTableViewCell: UITableViewCell {

    @IBOutlet private weak var heroImage: UIImageView!
    @IBOutlet private weak var heroName: UILabel!
    @IBOutlet private weak var heroPublisher: UILabel!
    static let identifier = "HeroTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "HeroTableViewCell", bundle: nil)
    }

    public func configure(with hero: SuperheroResponseModel) {
        heroImage.loadImage(with: hero.image.url)
        heroImage.contentMode = .scaleAspectFill
        heroName.text = hero.name
        heroPublisher.text = hero.biography.publisher
    }
    
    public func configure(with hero: superheroCollectionModel) {
        heroImage.loadImage(with: hero.image)
        heroImage.contentMode = .scaleAspectFill
        heroName.text = hero.name
        heroPublisher.text = hero.publisher
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
