//
//  ViewController.swift
//
//  Created by Snir Ganon on 25/1/2021.
//

import UIKit
import DDLibrary

class HerosViewController: UIViewController {
   
    @IBOutlet var heroesTableView: UITableView!
    @IBOutlet var lodingView: UIView!
    
    var heroes = [Hero]()
    var filteredHeroes: [Hero] = []
    var selectedHero: Hero?
    let searchController = UISearchController(searchResultsController: nil)
    var ShowSearchResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchController()
        self.searchController.searchBar.isHidden = true
        self.showFavoriteHeroes()
    }
    
    //MARK: - HerosViewController methods
    
    func configureSearchController() {
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Heros"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is HeroDetailsViewController
        {
            let heroForward = segue.destination as? HeroDetailsViewController

            if let indexPath = self.heroesTableView.indexPathForSelectedRow {
                if self.ShowSearchResults {
                    self.selectedHero = self.filteredHeroes[indexPath.row]
                }
                else {
                    self.selectedHero = self.heroes[indexPath.row]
                }
            }
            heroForward?.hero = self.selectedHero
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "OK", style: .cancel) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(closeAction)
        self.present(alertController, animated: true)
    }
    
    func showFavoriteHeroes() {
        // Show 3 heroes
        NetworkManager.shared.getHeroById(heroId: "346") { [weak self] (hero, error) in
            if let h = hero {
                self?.heroes.append(h)
            }
            if error != nil {
                if let domain = error?.domain {
                    self?.lodingView.isHidden = true
                    self?.showAlert(message: domain)
                }
            }
            NetworkManager.shared.getHeroById(heroId: "69") { [weak self] (hero, error) in
                if let h = hero {
                    self?.heroes.append(h)
                }
                if error != nil {
                    if let domain = error?.domain {
                        self?.showAlert(message: domain)
                    }
                }
                NetworkManager.shared.getHeroById(heroId: "644") { [weak self] (hero, error) in
                    if let h = hero {
                        self?.heroes.append(h)
                    }
                    if error != nil {
                        if let domain = error?.domain {
                            self?.showAlert(message: domain)
                        }
                    }
                    self?.searchController.searchBar.isHidden = false
                    self?.lodingView.isHidden = true
                    self?.heroesTableView.reloadData()
                }
            }
        }
    }
}

//MARK: - TableViewDelegate methods

extension HerosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ShowSearchResults {
            return self.filteredHeroes.count
        }
        else {
            return self.heroes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Hero", for: indexPath) as! HeroTableViewCell
        
        if self.ShowSearchResults {
            let hero = self.filteredHeroes[indexPath.row]
            cell.setHero(hero: hero)
        }
        else {
            let hero = self.heroes[indexPath.row]
            cell.setHero(hero: hero)
        }

        return cell
    }
}

//MARK: - Search bar methods

extension HerosViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Search hero
        self.lodingView.isHidden = false
        var send: String?
        if let searchWord = searchController.searchBar.text {
            send = searchWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
        if let name = send {
            NetworkManager.shared.getHeroBySearchName(heroName: "\(name)") { [weak self] (result, error) in
                if (error != nil) {
                    if let domain = error?.domain {
                        self?.lodingView.isHidden = true
                        self?.showAlert(message: domain)
                    }
                }
                else if let res = result?.results {
                    self?.filteredHeroes = res
                    self?.ShowSearchResults = true
                    self?.lodingView.isHidden = true
                    self?.heroesTableView.reloadData()
                }
            }
        }
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        ShowSearchResults = false
        self.heroesTableView.reloadData()
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        ShowSearchResults = false
        self.heroesTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            ShowSearchResults = false
            self.heroesTableView.reloadData()
        }
    }
}
