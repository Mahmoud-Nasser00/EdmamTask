//
//  ReciepsCollectionViewCell.swift
//  EdmamTask
//
//  Created by Mahmoud Nasser on 6/30/20.
//  Copyright © 2020 Mahmoud Nasser. All rights reserved.
//

import UIKit

class ReciepsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var reciepsView: UIView!
    @IBOutlet weak var reciepImageView: UIImageView!
    @IBOutlet weak var reciepeCatgoryLbl: UILabel!
    @IBOutlet weak var reciepeNameLbl: UILabel!


    func fillCellData(recipe: Recipe) {

        DataServices.downloudRecipePhoto(urlString: recipe.image) { (data, error) in
            guard let imageData = data else {
                print("no image data")
                return
            }
            DispatchQueue.main.async {
                self.reciepImageView.image = UIImage(data: imageData)
                self.setNeedsLayout()
            }
        
        }

        reciepeCatgoryLbl.text = recipe.label
        reciepeNameLbl.text = recipe.source
    }
}
