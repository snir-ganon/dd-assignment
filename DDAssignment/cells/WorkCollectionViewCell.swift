//
//  WorkCollectionViewCell.swift
//
//  Created by Snir Ganon on 25/1/2021.
//

import UIKit
import DDLibrary

class WorkCollectionViewCell: UICollectionViewCell {
    @IBOutlet var apiLabel: UILabel!
    @IBOutlet var occupationLabel: UILabel!
    @IBOutlet var baseLabel: UILabel!
    
    func setDetails(work: Work) {
        self.apiLabel.text = "Work:"
        self.occupationLabel.text = "Occupation: \(work.occupation)."
        self.baseLabel.text = "Base: \(work.base)."
    }
}
