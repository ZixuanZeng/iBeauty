//
//  DataHandler.swift
//  Capstone Project
//
//  Created by Zixuan Zeng on 11/22/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import UIKit
import CoreData

/* This class is the core data handler which handles all the operations related to data management*/

class DataHandler: NSManagedObject {
    
    // Create an entity for storing actions related to Core Data
    var adjustments: [NSManagedObject] = []
    
    //MARK: - Action for saving all the parameter values from each adjustment panel
    func saveParameters(buttonOne: Bool, buttonTwo: Bool, buttonThree: Bool, buttonFour: Bool, buttonFive: Bool, sliderOne: Float, sliderTwo: Float, sliderThree: Float, adjustmentID: Int, typeID: Int, categoryID: Int) {
        
        // Before saving or retrieving anything from Core Data store, first get delegate on NSManagedObjectContext
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create a new managed object and insert it into the managed object context
        let entity = NSEntityDescription.entity(forEntityName: "AdjustmentParameters", in: managedContext)!
        
        let adjustmentParameters = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set each attribute in this entity using key-value coding
        adjustmentParameters.setValue(buttonOne, forKeyPath: "buttonOne")
        adjustmentParameters.setValue(buttonTwo, forKeyPath: "buttonTwo")
        adjustmentParameters.setValue(buttonThree, forKeyPath: "buttonThree")
        adjustmentParameters.setValue(buttonFour, forKeyPath: "buttonFour")
        adjustmentParameters.setValue(buttonFive, forKeyPath: "buttonFive")
        adjustmentParameters.setValue(sliderOne, forKeyPath: "sliderOne")
        adjustmentParameters.setValue(sliderTwo, forKeyPath: "sliderTwo")
        adjustmentParameters.setValue(sliderThree, forKeyPath: "sliderThree")
        adjustmentParameters.setValue(adjustmentID, forKeyPath: "adjustmentID")
        adjustmentParameters.setValue(typeID, forKeyPath: "typeID")
        adjustmentParameters.setValue(categoryID, forKeyPath: "categoryID")
        
        // Commit changes to this entity and save to disk by calling save on the managed object context
        do {
            try managedContext.save()
            adjustments.append(adjustmentParameters)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: - Action for fetching data from Core Data database
    func fetchAllParameters(_entityName: String) {
        // Get contact to Core Data, managed object context
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Fetch action
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: _entityName)
        
        // Hand the fetch request over to the managed object context to do the heavy lifting
        do {
            adjustments = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
