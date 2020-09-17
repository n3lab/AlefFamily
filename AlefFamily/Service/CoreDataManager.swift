//
//  CoreDataManager.swift
//  AlefFamily
//
//  Created by n3deep on 16.09.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {
    }
    
    var container: NSPersistentContainer!
    
    let dbName: String = "AlefFamily"
        
    func loadDataBaseNamed() {
        container = NSPersistentContainer(name: dbName)
        container.loadPersistentStores { storeDescription, error in
        self.container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    func fetchParent() -> Parent? {
        var parents = [Parent]()
        
        let request = Parent.createFetchRequest()
        
        do {
            parents = try container.viewContext.fetch(request)
            return parents.first
        } catch {
            print("Fetch failed")
            return nil
        }
    }
    
    func updateParent(name: String, middleName: String, surname: String, age: Int) {
        var parents = [Parent]()
        let request = Parent.createFetchRequest()
        do {
            parents = try container.viewContext.fetch(request)
            if let parent = parents.first {
                parent.name = name
                parent.middleName = middleName
                parent.surname = surname
                parent.age = Int16(age)
            } else {
                let parent = Parent(context: self.container.viewContext)
                parent.name = name
                parent.middleName = middleName
                parent.surname = surname
                parent.age = Int16(age)
            }
            saveContext()
        } catch {
            print("Update failed")
        }
    }
    
    func addChild(name: String, age: Int) {
        let child = Child(context: self.container.viewContext)
        child.name = name
        child.age = Int16(age)
        saveContext()
    }
        
    func deleteChild(_ child: Child) {
        let context = container.viewContext
        context.delete(child)
        self.saveContext()
    }
    
    func fetchKids() -> [Child] {
        var childs = [Child]()
        let request = Child.createFetchRequest()
        
        do {
            childs = try container.viewContext.fetch(request)
            return childs
        } catch {
            print("Fetch failed")
            return [Child]()
        }
    }
}
