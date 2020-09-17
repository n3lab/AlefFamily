//
//  ViewController.swift
//  AlefFamily
//
//  Created by n3deep on 16.09.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//

import UIKit

class FamilyController: UIViewController {

    @IBOutlet weak var familyTableView: UITableView!
    
    let sectionTitles: [(section: Int, name: String)] = [(0, "Родитель"),
                                                         (1, "Дети"),
                                                         (2, "Добавить")]

    let sectionHeaderIdentifier: String = "SectionHeader"

    let nameCellIdentifier: String = "NameCell"
    let addChildCellIdentifier: String = "AddChildCell"
    let childCellIdentifier: String = "ChildCell"
    
    let parentTitles: [(row: Int, name: String)] = [(0, "Фамилия"),
                                                    (1, "Имя"),
                                                    (2, "Отчество"),
                                                    (3, "Возраст")]
    
    var kids: [Int] = []
    
    var isChildrenLimitReached: Bool = false
    
    var viewModel: FamilyViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        familyTableView.delegate = self
        familyTableView.dataSource = self
        
        viewModel = FamilyViewModel()
        if viewModel?.maxKids == viewModel?.kids?.count {
            isChildrenLimitReached = true
        }
        
        self.hideKeyboardWhenTappedAround()
        
        setupFamilyTableView()
    }

    func setupFamilyTableView() {
        let nameCellNib = UINib(nibName: nameCellIdentifier, bundle: nil)
        familyTableView.register(nameCellNib, forCellReuseIdentifier: nameCellIdentifier)
        let sectionHeaderNib = UINib(nibName: sectionHeaderIdentifier, bundle: nil)
        familyTableView.register(sectionHeaderNib, forCellReuseIdentifier: sectionHeaderIdentifier)
        let addChildNib = UINib(nibName: addChildCellIdentifier, bundle: nil)
        familyTableView.register(addChildNib, forCellReuseIdentifier: addChildCellIdentifier)
        let childNib = UINib(nibName: childCellIdentifier, bundle: nil)
        familyTableView.register(childNib, forCellReuseIdentifier: childCellIdentifier)
        
        familyTableView.rowHeight = UITableView.automaticDimension
        familyTableView.sectionFooterHeight = .leastNormalMagnitude
    }

}

extension FamilyController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section].name
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {return 0.0 }
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let cell = tableView.dequeueReusableCell(withIdentifier: sectionHeaderIdentifier) as! SectionHeader
        cell.titleLabel.text = sectionTitles[section].name
        return cell.contentView

    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return parentTitles.count
        case 1:
            return viewModel?.kids?.count ?? 0
        case 2:
            let numberOfRows = isChildrenLimitReached ? 0 : 1
            return numberOfRows
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: nameCellIdentifier, for: indexPath) as! NameCell
            cell.selectionStyle = .none
            cell.nameLabel.text = parentTitles[indexPath.row].name
            cell.cellDelegate = self
            
            switch indexPath.row {
            case 0:
                cell.nameTextField.text = viewModel?.surname
            case 1:
                cell.nameTextField.text = viewModel?.name
            case 2:
                cell.nameTextField.text = viewModel?.middleName
            case 3:
                if let age = viewModel?.age {
                    cell.nameTextField.text = String(age)
                }
                cell.nameTextField.keyboardType = .numberPad
            default:
                break
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: childCellIdentifier, for: indexPath) as! ChildCell
            cell.selectionStyle = .none
            cell.cellDelegate = self
            cell.removeButton.tag = indexPath.row
            cell.nameLabel.text = viewModel?.kids?[indexPath.row].name
            if let int16Age = viewModel?.kids?[indexPath.row].age {
                cell.ageLabel.text = String(describing: int16Age)
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: addChildCellIdentifier, for: indexPath) as! AddChildCell
            cell.selectionStyle = .none
            cell.cellDelegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension FamilyController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension FamilyController: ChildCellDelegate {
    func removeChildButtonPressed(cell: ChildCell) {
        if let indexPath = familyTableView.indexPath(for: cell) {
            
            guard let deletedKid = viewModel?.kids?[indexPath.row] else {
                return
            }
            viewModel?.deleteKid(deletedKid)
            familyTableView.deleteRows(at: [indexPath], with: .middle)
        }
        
        guard let maxKids = viewModel?.maxKids else {
            return
        }
        let okKids = maxKids - 1
        if viewModel?.kids?.count == okKids {
            isChildrenLimitReached = false
            let addChildRowIndexPath = IndexPath(row: 0, section: 2)
            familyTableView.insertRows(at: [addChildRowIndexPath], with: .none)
        }
    }
}

extension FamilyController: AddChildCellDelegate {
    func addChildButtonPressed() {
        
        let alertController = UIAlertController(title: "Добавить ребенка", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Имя"
            textField.isSecureTextEntry = false
            textField.textAlignment = .center
        }
        alertController.addTextField { textField in
            textField.placeholder = "Возраст"
            textField.isSecureTextEntry = false
            textField.textAlignment = .center
            textField.keyboardType = .numberPad
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            print("Отмена")
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
            
            guard let name = alertController.textFields?[0].text else {
                self.showErrorAlert(error: "Некорректное имя")
                return
            }
            
            guard let age = Int(alertController.textFields?[1].text ?? "") else {
                self.showErrorAlert(error: "Некорректный возраст")
                return
            }
            
            self.addChild(name: name, age: age)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func addChild(name: String, age: Int) {
        let indexPath = IndexPath(row: viewModel?.kids?.count ?? 0, section: 1)
        viewModel?.addKid(name: name, age: age)
        
        familyTableView.insertRows(at: [indexPath], with: .bottom)
        if viewModel?.kids?.count == viewModel?.maxKids {
            isChildrenLimitReached = true
            let addChildRowIndexPath = IndexPath(row: 0, section: 2)
            familyTableView.deleteRows(at: [addChildRowIndexPath], with: .none)
        }
    }
    
    func showErrorAlert(error: String) {
        let alertController = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ок", style: .cancel) { _ in
            print("Ок")
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension FamilyController: NameCellDelegate {
    func textFieldEdited(cell: NameCell) {
        if let indexPath = familyTableView.indexPath(for: cell) {
            switch indexPath.row {
            case 0:
                viewModel?.surname = cell.nameTextField.text
            case 1:
                viewModel?.name = cell.nameTextField.text
            case 2:
                viewModel?.middleName = cell.nameTextField.text
            case 3:
                viewModel?.age = Int(cell.nameTextField.text ?? "")
            default:
                break
            }
            
            viewModel?.updateParent()
        }
    }
}


