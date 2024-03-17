//
//  FavouritesViewController.swift
//  UrlSession_0
//
//  Created by Настя Сарамуд on 14.03.2024.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    var favouriteArticles: [SelectedArticle] = []
    private lazy var dataManager = CoreDataManager.shared
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        favouriteArticles = dataManager.fetchSelectedArticles()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        favouriteArticles = dataManager.fetchSelectedArticles()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.identifierSegue,
              let detailFVC = segue.destination as? FavouriteDetailedViewController
        else { return }
        
        detailFVC.articleFavourite = sender as? SelectedArticle
        
        print("Preparing for segue with selectedArticle: \(favouriteArticles)")
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favouriteArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifierCell, for: indexPath)
        let favouriteArticle = favouriteArticles[indexPath.row]
        
        cell.textLabel?.text = favouriteArticle.title
        cell.detailTextLabel?.text = favouriteArticle.section
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = favouriteArticles[indexPath.row]
        performSegue(withIdentifier: Constants.identifierSegue, sender: info)
        
        print("Row selected at indexPath: \(indexPath)")
    }
}

private enum Constants {
    static let identifierCell = "cellFavourite"
    static let identifierSegue = "detailedInformationFavourite"
}
