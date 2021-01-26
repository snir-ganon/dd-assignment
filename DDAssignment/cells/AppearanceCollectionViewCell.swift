//
//  HeroDetailsCollectionViewCell.swift
//
//  Created by Snir Ganon on 25/1/2021.
//

import UIKit
import DDLibrary

class AppearanceCollectionViewCell: UICollectionViewCell {
    @IBOutlet var apiLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var raceLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    
    func setDetails(appearance: Appearance) {
        self.apiLabel.text = "Appearance:"
        self.genderLabel.text = "Gender: \(appearance.gender)."
        self.raceLabel.text = "Race: \(appearance.race)."
        self.heightLabel.text = "Height: \(appearance.height[1])."
        self.weightLabel.text = "Weight: \(appearance.weight[1])."
    }
}
