//
//  DetailsViewController.swift
//  EdmamTask
//
//  Created by Mahmoud Nasser on 7/1/20.
//  Copyright © 2020 Mahmoud Nasser. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var ingredientsTV: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLbl: UILabel!
    @IBOutlet weak var sourceLbl: UILabel!

    var recipe: Recipe!

    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTV.rowHeight = UITableView.automaticDimension
//        ingredientsTV.estimatedRowHeight = 70
    
        ingredientsTV.delegate = self
        ingredientsTV.dataSource = self
        fillHeaderView()
    }


    private func fillHeaderView() {
        recipeNameLbl.text = recipe.label
        sourceLbl.text = recipe.source
        setRecipePhoto()
    }

    private func setRecipePhoto() {
        DataServices.downloudRecipePhoto(urlString: recipe.image) { (data, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.recipeImage.image = UIImage(data: data)
            }
        }
    }

    @IBAction func backBtnTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
        
    }
    
}

extension DetailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.ingredientLines.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as? IngradientsTableViewCell {

            let ingredientForRow = recipe.ingredientLines[indexPath.row]
            cell.fillCellData(ingredientLine: ingredientForRow)
            return cell
        }
        return UITableViewCell()
    }


}
