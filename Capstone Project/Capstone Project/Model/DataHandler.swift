//
//  DataHandler.swift
//  Capstone Project
//
//  Created by Zixuan Zeng on 11/22/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import UIKit
import CoreData

/* This class is the Core Data handler which handles all the operations related to data management*/

internal class DataHandler: NSManagedObject {
    
    // Create an entity for storing actions related to Core Data
    var adjustments: [NSManagedObject] = []
    var fetchedRecordArray: [NSManagedObject] = []
    
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
    func saveAllAdjustmentParameters(imageID: Int?, categoryID: Int?, lightID: Int?, colorID: Int?, detailID: Int?, filterID: Int?) {
        
        // Before saving or retrieving anything from Core Data store, first get delegate on NSManagedObjectContext
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create a new managed object and insert it into the managed object context
        let entity = NSEntityDescription.entity(forEntityName: "EditedImage", in: managedContext)!
        
        let adjustmentParameters = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Unwrap the optional values safely
        guard let image = imageID, let category = categoryID, let light = lightID, let color = colorID, let detail = detailID, let filter = filterID else {
            return
        }
        
        // Set each attribute in this entity using key-value coding
        adjustmentParameters.setValue(image, forKeyPath: "imageID")
        adjustmentParameters.setValue(category, forKeyPath: "categoryID")
        adjustmentParameters.setValue(light, forKeyPath: "lightID")
        adjustmentParameters.setValue(color, forKeyPath: "colorID")
        adjustmentParameters.setValue(detail, forKeyPath: "detailID")
        adjustmentParameters.setValue(filter, forKeyPath: "filterID")
        
        // Commit changes to this entity and save to disk by calling save on the managed object context
        do {
            try managedContext.save()
            adjustments.append(adjustmentParameters)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: - Action for saving image category info into ImageCategories entity
    func saveImageCategory(categoryID: Int) {
        // Before saving or retrieving anything from Core Data store, first get delegate on NSManagedObjectContext
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create a new managed object and insert it into the managed object context
        let entity = NSEntityDescription.entity(forEntityName: "ImageCategories", in: managedContext)!
        
        let imageInfo = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set each attribute using key-value coding
        switch categoryID {
        case 1:
            imageInfo.setValue(categoryID, forKeyPath: "categoryID")
            imageInfo.setValue("Landscape", forKeyPath: "categoryName")
        case 2:
            imageInfo.setValue(categoryID, forKeyPath: "categoryID")
            imageInfo.setValue("Portrait", forKeyPath: "categoryName")
        default:
            imageInfo.setValue(categoryID, forKeyPath: "categoryID")
            imageInfo.setValue("Documentary", forKeyPath: "categoryName")
        }
        
        // Commit changes to this entity and save to disk by calling save on the managed object context
        do {
            try managedContext.save()
            adjustments.append(imageInfo)
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
            fetchedRecordArray = try managedContext.fetch(fetchRequest)
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
    
    //MARK: -Action for creating export strings from Core Data's attribute (converting data base values into rows of strings)
    func createRecordString() -> String {
        var categoryName: String?; var exposure: Float?; var highlight: Float?; var shadow: Float?; var bw: Float?
        var hue: Float?; var temperature: Float?; var saturation: Float?; var vignette: Float?; var nr: Float?
        var contrast: Float?; var sr: Float?; var si: Float?; var kodak: Float?; var instant: Float?
        var fujifilm: Float?; var gamma: Float?; var tone: Float?; var rgb: Float?
        
        var export: String = NSLocalizedString("imageCategory, exposure, highlight, shadow, black and white, hue, temperature, saturation, vignette, noise reduction, contrast, sharpness radius, sharpness intensity, kodak film, instant film, fujifilm, gamma, tone curve, rgb curve \n", comment: "")
        for (index, itemList) in fetchedRecordArray.enumerated() {
            if index <= fetchedRecordArray.count - 1 {
                categoryName = itemList.value(forKey: "imageCategory") as! String?; exposure = itemList.value(forKey: "exposure") as! Float?; highlight = itemList.value(forKey: "highlight") as! Float?; shadow = itemList.value(forKey: "shadow") as! Float?; bw = itemList.value(forKey: "bw") as! Float?
                hue = itemList.value(forKey: "hue") as! Float?; temperature = itemList.value(forKey: "temperature") as! Float?; saturation = itemList.value(forKey: "saturation") as! Float?; vignette = itemList.value(forKey: "vignette") as! Float?; nr = itemList.value(forKey: "nr") as! Float?
                contrast = itemList.value(forKey: "contrast") as! Float?; sr = itemList.value(forKey: "sr") as! Float?; si = itemList.value(forKey: "si") as! Float?; kodak = itemList.value(forKey: "kodak") as! Float?; instant = itemList.value(forKey: "instant") as! Float?
                fujifilm = itemList.value(forKey: "fujifilm") as! Float?; gamma = itemList.value(forKey: "gamma") as! Float?; tone = itemList.value(forKey: "tone") as! Float?; rgb = itemList.value(forKey: "rgb") as! Float?
                let imageCategoryString = categoryName; let exposureString = exposure; let highlightString = highlight; let shadowString = shadow; let bwString =  bw
                let hueString = hue; let temperatureString = temperature; let saturationString = saturation; let vignetteString = vignette; let nrString = nr
                let contrastString = contrast; let srString = sr; let siString = si; let kodakString = kodak; let instantString = instant
                let fujifilmString = fujifilm; let gammaString = gamma; let toneString = tone; let rgbString = rgb
                export += "\(imageCategoryString!),\(exposureString!),\(highlightString!),\(shadowString!),\(bwString!),\(hueString!),\(temperatureString!),\(saturationString!),\(vignetteString!),\(nrString!),\(contrastString!),\(srString!),\(siString!),\(kodakString!),\(instantString!),\(fujifilmString!),\(gammaString!),\(toneString!),\(rgbString!) \n"
            }
        }
        // This is for debug only
        print("This is what the app will export: \(export)")
        return export
    }
    
    //MARK: -Action for exporting Core Data values to a CSV file; prepare for ML model training
    func saveAndExport(exportString: String) {
        let exportFilePath = NSTemporaryDirectory() + "MachineLearning.csv"
        let exportFileURL = NSURL(fileURLWithPath: exportFilePath)
        FileManager.default.createFile(atPath: exportFilePath, contents: NSData() as Data, attributes: nil)
        //var fileHandleError: NSError? = nil
        var fileHandle: FileHandle? = nil
        do {
            fileHandle = try FileHandle(forWritingTo: exportFileURL as URL)
        } catch {
            print("Error with fileHandle")
        }
        
        if fileHandle != nil {
            fileHandle!.seekToEndOfFile()
            let csvData = exportString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            fileHandle!.write(csvData!)
            
            fileHandle!.closeFile()
        }
    }
    
    //MARK: -Action for exporting to temorary file directory
    func exportDatabase() {
        let exportString = createRecordString()
        saveAndExport(exportString: exportString)
    }
}
