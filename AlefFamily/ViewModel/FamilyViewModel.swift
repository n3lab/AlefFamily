//
//  FamilyViewModel.swift
//  AlefFamily
//
//  Created by n3deep on 16.09.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//

import Foundation

class FamilyViewModel {
    
    var kids: [Child]?
    
    var surname: String?
    var name: String?
    var middleName: String?
    var age: Int?
    
    let maxKids: Int = 5
    
    init() {
        
        CoreDataManager.shared.loadDataBaseNamed()
        
        fetchParent()
        fetchKids()
    }
    
    func fetchParent() {
        guard let parent = CoreDataManager.shared.fetchParent() else {
            return
        }
        self.surname = parent.surname
        self.name = parent.name
        self.middleName = parent.middleName
        self.age = Int(parent.age)
    }
    
    func updateParent() {
        CoreDataManager.shared.updateParent(name: self.name ?? "", middleName: self.middleName ?? "", surname: self.surname ?? "", age: self.age ?? 0)
    }
    
    func fetchKids() {
        self.kids = CoreDataManager.shared.fetchKids()
    }
        
    func addKid(name: String, age: Int) {
        CoreDataManager.shared.addChild(name: name, age: age)
        self.kids = CoreDataManager.shared.fetchKids()
    }
    
    func deleteKid(_ child: Child) {
        CoreDataManager.shared.deleteChild(child)
        self.kids = CoreDataManager.shared.fetchKids()
    }
}
