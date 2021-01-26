//
//  HeroTableViewCell.swift
//
//  Created by Snir Ganon on 25/1/2021.
//

import UIKit
import DDLibrary

class HeroTableViewCell: UITableViewCell {
    @IBOutlet var heroNameLabel: UILabel!
    @IBOutlet var heroImage: UIImageView!
    
    func setHero(hero: Hero) {
        self.heroNameLabel.text = hero.name
        
        self.heroImage.layer.cornerRadius = 32.5
        if let url = URL(string: hero.image.url) {
            self.heroImage.af.setImage(withURL: url)
        }
    }
    
    override func prepareForReuse() {
        self.heroImage.image = nil
    }
}
