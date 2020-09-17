//
//  NameCell.swift
//  AlefFamily
//
//  Created by n3deep on 16.09.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//

import UIKit

protocol NameCellDelegate: class {
    func textFieldEdited(cell: NameCell)
}

class NameCell: UITableViewCell {

    weak var cellDelegate: NameCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        nameTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension NameCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        cellDelegate?.textFieldEdited(cell: self)
    }
}
