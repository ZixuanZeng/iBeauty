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
    
    //MARK: - Action for saving all the parameter values from light adjustment panel (for light adjustment only)
    func saveLightParameters(lightID: Int, sliderOne: Float, sliderTwo: Float, sliderThree: Float) {
        
        // Before saving or retrieving anything from Core Data store, first get delegate on NSManagedObjectContext
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create a new managed object and insert it into the managed object context
        let entity = NSEntityDescription.entity(forEntityName: "LightParameters", in: managedContext)!
        
        let adjustmentParameters = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set each attribute in this entity using key-value coding
        adjustmentParameters.setValue(lightID, forKeyPath: "lightID")
        adjustmentParameters.setValue(sliderOne, forKeyPath: "sliderOne")
        adjustmentParameters.setValue(sliderTwo, forKeyPath: "sliderTwo")
        adjustmentParameters.setValue(sliderThree, forKeyPath: "sliderThree")
        
        // Commit changes to this entity and save to disk by calling save on the managed object context
        do {
            try managedContext.save()
            adjustments.append(adjustmentParameters)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: - Action for saving all the parameter values from color adjustment panel (for color adjustment only)
    func saveColorParameters(colorID: Int, button: Float, sliderOne: Float, sliderTwo: Float, sliderThree: Float) {
        
        // Before saving or retrieving anything from Core Data store, first get delegate on NSManagedObjectContext
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create a new managed object and insert it into the managed object context
        let entity = NSEntityDescription.entity(forEntityName: "ColorParameters", in: managedContext)!
        
        let adjustmentParameters = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set each attribute in this entity using key-value coding
        adjustmentParameters.setValue(colorID, forKeyPath: "colorID")
        adjustmentParameters.setValue(button, forKeyPath: "button")
        adjustmentParameters.setValue(sliderOne, forKeyPath: "sliderOne")
        adjustmentParameters.setValue(sliderTwo, forKeyPath: "sliderTwo")
        adjustmentParameters.setValue(sliderThree, forKeyPath: "sliderThree")
        
        // Commit changes to this entity and save to disk by calling save on the managed object context
        do {
            try managedContext.save()
            adjustments.append(adjustmentParameters)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: - Action for saving all the parameter values from detail adjustment panel (for detail adjustment only)
    func saveDetailParameters(detailID: Int, buttonOne: Float, buttonTwo: Float, sliderOne: Float, sliderTwo: Float, sliderThree: Float) {
        
        // Before saving or retrieving anything from Core Data store, first get delegate on NSManagedObjectContext
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create a new managed object and insert it into the managed object context
        let entity = NSEntityDescription.entity(forEntityName: "DetailParameters", in: managedContext)!
        
        let adjustmentParameters = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set each attribute in this entity using key-value coding
        adjustmentParameters.setValue(detailID, forKeyPath: "detailID")
        adjustmentParameters.setValue(buttonOne, forKeyPath: "buttonOne")
        adjustmentParameters.setValue(buttonTwo, forKeyPath: "buttonTwo")
        adjustmentParameters.setValue(sliderOne, forKeyPath: "sliderOne")
        adjustmentParameters.setValue(sliderTwo, forKeyPath: "sliderTwo")
        adjustmentParameters.setValue(sliderThree, forKeyPath: "sliderThree")
        
        // Commit changes to this entity and save to disk by calling save on the managed object context
        do {
            try managedContext.save()
            adjustments.append(adjustmentParameters)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: - Action for saving all the parameter values from filter adjustment panel (for filter adjustment only)
    func saveFilterParameters(filterID: Int, buttonOne: Float, buttonTwo: Float, buttonThree: Float, buttonFour: Float, buttonFive: Float, buttonSix: Float) {
        
        // Before saving or retrieving anything from Core Data store, first get delegate on NSManagedObjectContext
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create a new managed object and insert it into the managed object context
        let entity = NSEntityDescription.entity(forEntityName: "FilterParameters", in: managedContext)!
        
        let adjustmentParameters = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set each attribute in this entity using key-value coding
        adjustmentParameters.setValue(filterID, forKeyPath: "filterID")
        adjustmentParameters.setValue(buttonOne, forKeyPath: "buttonOne")
        adjustmentParameters.setValue(buttonTwo, forKeyPath: "buttonTwo")
        adjustmentParameters.setValue(buttonThree, forKeyPath: "buttonThree")
        adjustmentParameters.setValue(buttonFour, forKeyPath: "buttonFour")
        adjustmentParameters.setValue(buttonFive, forKeyPath: "buttonFive")
        adjustmentParameters.setValue(buttonSix, forKeyPath: "buttonSix")
        
        // Commit changes to this entity and save to disk by calling save on the managed object context
        do {
            try managedContext.save()
            adjustments.append(adjustmentParameters)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: - Action for saving all the parameter values from all panels to Core Data
    func saveAllAdjustmentParameters(imageID: Int, categoryID: Int, lightID: Int, colorID: Int, detailID: Int, filterID: Int) {
        
        // Before saving or retrieving anything from Core Data store, first get delegate on NSManagedObjectContext
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create a new managed object and insert it into the managed object context
        let entity = NSEntityDescription.entity(forEntityName: "EditedImage", in: managedContext)!
        
        let adjustmentParameters = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set each attribute in this entity using key-value coding
        adjustmentParameters.setValue(imageID, forKeyPath: "imageID")
        adjustmentParameters.setValue(categoryID, forKeyPath: "categoryID")
        adjustmentParameters.setValue(lightID, forKeyPath: "lightID")
        adjustmentParameters.setValue(colorID, forKeyPath: "colorID")
        adjustmentParameters.setValue(detailID, forKeyPath: "detailID")
        adjustmentParameters.setValue(filterID, forKeyPath: "filterID")
        
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
    
    //MARK: - Action for getting count of entity elements
    func getNumberOfObject(_entityName: String) -> Int {
        // Variable to hold number of objects
        var numberOfObject: Int = 0
        // Get contact to Core Data, managed object context
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return 0
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Fetch action
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: _entityName)
        
        // fetch number of objects
        do {
            numberOfObject = try managedContext.count(for: fetchRequest)
        } catch let error as NSError {
            print("Could not count objects.\(error), \(error.userInfo)")
        }
        
        return numberOfObject
    }
}
