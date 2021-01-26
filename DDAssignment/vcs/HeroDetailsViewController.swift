//
//  HeroDetailsViewController.swift
//
//  Created by Snir Ganon on 25/1/2021.
//

import UIKit
import Alamofire
import AlamofireImage
import DDLibrary

class HeroDetailsViewController: UIViewController {
    @IBOutlet var heroImage: UIImageView!
    @IBOutlet var heroFullName: UILabel!
    @IBOutlet var herofirstAppearance: UILabel!
    @IBOutlet var heroPublisher: UILabel!
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Share option
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let h = hero {
            self.title = h.name
            self.heroFullName.text = "Full name: \(h.biography.fullName)"
            self.herofirstAppearance.text = "First appearance: \(h.biography.firstAppearance)."
            self.heroPublisher.text = "Publisher: \(h.biography.publisher)."
            if let url = URL(string: h.image.url) {
                self.heroImage.af.setImage(withURL: url)
            }
        }
    }
    
    // MARK: Others methods
    
    @objc func shareTapped() {
        let isConnector = "is"
        if let h = hero {
            let vc = UIActivityViewController(activityItems: [h.biography.fullName, isConnector, h.name], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
                present(vc, animated: true)
        }
    }
}

extension HeroDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Appearance cell
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Appearance", for: indexPath) as? AppearanceCollectionViewCell else {
                fatalError("Unable to dequeue PersonCell.")
            }
            if let h = hero {
                cell.setDetails(appearance: h.appearance)
            }
            return cell
        }
        // Connection Cell
        else if indexPath.row == 1 {
            guard let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "Connections", for: indexPath) as? ConnectionsCollectionViewCell else {
                fatalError("Unable to dequeue PersonCell.")
            }
            if let h = hero {
                cell2.setDetails(connection: h.connections)
            }
            return cell2
        }
        else {
            // Work cell
            guard let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "Work", for: indexPath) as? WorkCollectionViewCell else {
                fatalError("Unable to dequeue PersonCell.")
            }
            if let h = hero {
                cell3.setDetails(work: h.work)
            }
            return cell3
        }
    }
}
