//
//  AddChildCell.swift
//  AlefFamily
//
//  Created by n3deep on 16.09.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//

import UIKit

protocol AddChildCellDelegate: class {
    func addChildButtonPressed()
}

class AddChildCell: UITableViewCell {

    weak var cellDelegate: AddChildCellDelegate?
    
    @IBAction func addButtonPressed(_ sender: Any) {
        cellDelegate?.addChildButtonPressed()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
