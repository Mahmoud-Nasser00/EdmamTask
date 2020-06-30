//
//  ViewController.swift
//  EdmamTask
//
//  Created by Mahmoud Nasser on 6/30/20.
//  Copyright © 2020 Mahmoud Nasser. All rights reserved.
//

import UIKit

class ReciepsViewController: UIViewController {

    let debuggingTag = "ReciepsViewController "
    let searchController = UISearchController()

    //MARK:- IBOutlets

    @IBOutlet weak var recipesCollectionView: UICollectionView!

    //MARK:- Variables

    var hits = [Hit]()


    //MARK:- App life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavSearchButton()
        setupContactSearchController(searchController: searchController)
        getRecipes()
    }

    //MARK:- Functions

    private func getRecipes() {

        DataServices.getRecipes(q: "fish") { (recipeResponse, error) in
            if let recipeResponse = recipeResponse {
                print(self.debuggingTag, recipeResponse)

                self.hits = recipeResponse.hits
                self.recipesCollectionView.reloadData()
            }

            if let error = error {
                print(self.debuggingTag, error)
            }
        }
    }

    private func setNavSearchButton() {
        let navSearchBtn = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(searchBtnTapped))
        self.navigationItem.rightBarButtonItem = navSearchBtn
    }

    private func setupContactSearchController(searchController: UISearchController) {
        searchController.searchResultsUpdater = self
//          searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search In contact"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    //MARK:- IBActions

    @objc func searchBtnTapped() {
    }


    //MARK:- Navigation

}

//MARK:- Extensions

extension ReciepsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let detailsVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController {
            detailsVC.modalPresentationStyle = .fullScreen
            detailsVC.recipe = hits[indexPath.row].recipe
            present(detailsVC, animated: true, completion: nil)
        }

    }
}

extension ReciepsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hits.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellId.recipeCell, for: indexPath) as? ReciepsCollectionViewCell {

            let hitForRow = hits[indexPath.row]

            cell.fillCellData(recipe: hitForRow.recipe)
            return cell
        }

        return UICollectionViewCell()
    }


}

extension ReciepsViewController: UICollectionViewDelegateFlowLayout {

}

extension ReciepsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

        let searchText = String(searchController.searchBar.text ?? " ")

        DataServices.getRecipes(q: searchText) { (response, error) in
            guard let response = response else { return }
            self.hits = response.hits
            self.recipesCollectionView.reloadData()
        }
    }


}
