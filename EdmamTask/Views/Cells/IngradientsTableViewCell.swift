//
//  IngradientsTableViewCell.swift
//  EdmamTask
//
//  Created by Mahmoud Nasser on 7/1/20.
//  Copyright © 2020 Mahmoud Nasser. All rights reserved.
//

import UIKit

class IngradientsTableViewCell: UITableViewCell {

    @IBOutlet weak var dotLbl: UILabel!
    @IBOutlet weak var ingredientLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dotLbl.layer.cornerRadius = 7
        dotLbl.layer.masksToBounds = true
    }

    
    func fillCellData(ingredientLine:String){
        ingredientLbl.text = ingredientLine
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
