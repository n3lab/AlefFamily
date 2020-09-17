//
//  ChildCell.swift
//  AlefFamily
//
//  Created by n3deep on 16.09.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//

import UIKit

protocol ChildCellDelegate: class {
    func removeChildButtonPressed(cell: ChildCell)
}

class ChildCell: UITableViewCell {

    weak var cellDelegate: ChildCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBAction func removeButtonPressed(_ sender: UIButton) {
        cellDelegate?.removeChildButtonPressed(cell: self)
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
