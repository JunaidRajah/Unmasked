//
//  HeroTableViewCell.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/08.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    @IBOutlet private weak var heroImage: UIImageView!
    @IBOutlet private weak var heroName: UILabel!
    @IBOutlet private weak var heroPublisher: UILabel!
    static let identifier = "HeroTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "HeroTableViewCell", bundle: nil)
    }

    public func configure(with hero: SuperheroResponseModel) {
        if let url = URL(string: hero.image.url) {
            heroImage.contentMode = .scaleAspectFit
            heroImage.image = UIImage(systemName: "arrow.clockwise")
            DispatchQueue.main.async {
                self.heroImage.load(url: url)
            }
            heroImage.contentMode = .scaleAspectFill
        }
        heroName.text = hero.name
        heroPublisher.text = hero.biography.publisher
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
