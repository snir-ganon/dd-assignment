//
//  PowerstatsCollectionViewCell.swift
//
//  Created by Snir Ganon on 25/1/2021.
//

import UIKit
import DDLibrary

class ConnectionsCollectionViewCell: UICollectionViewCell {
    @IBOutlet var apiLabel: UILabel!
    @IBOutlet var groupAffiliationLabel: UILabel!
    @IBOutlet var relativesLabel: UILabel!
    
    func setDetails(connection: Connections) {
        self.apiLabel.text = "Connections:"
        self.groupAffiliationLabel.text = "Group: \(connection.groupAffiliation)."
        self.relativesLabel.text = "Relatives: \(connection.relatives)."
    }
    
}
