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
    
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var recipesCollectionView: UICollectionView!
    
    //MARK:- Variables
    
    var recipes = [Hit]()
    
    
    //MARK:- App life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getRecipes()
        
    }

    //MARK:- Functions
    
    func getRecipes(){
//        DataServices.getWelcome()
        
//        DataServices.alamotask()
        DataServices.getRecipes { (welcome, error) in
            if let welcome = welcome {
                print(self.debuggingTag,welcome)
                
                self.recipes = welcome.hits
                self.recipesCollectionView.reloadData()
            }
            
            if let error = error {
                print(self.debuggingTag,error)
            }
        }
    }
    
    //MARK:- Navigation
    
}

//MARK:- Extensions

extension ReciepsViewController : UICollectionViewDelegate {
    
}

extension ReciepsViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellId.recipeCell, for: indexPath) as? ReciepsCollectionViewCell {
            
            let recipeForRow = recipes[indexPath.row]
            
            cell.fillCellData(recipe: recipeForRow.recipe)
            return cell
        }
        
        return UICollectionViewCell()
    }
    

}

extension ReciepsViewController : UICollectionViewDelegateFlowLayout{
    
}
