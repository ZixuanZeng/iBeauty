//
//  NeuralNetwork.swift
//  Capstone Project
//
//  Created by Zixuan Zeng on 11/25/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import UIKit
import CoreData
import CoreML
import ImageIO
import Vision

class NeuralNetwork: NSManagedObject {
    // This variable is to hold classification result
    var category: String = " "
    // Here is to integrate my models to the app
    // Try to create the model using initializer
    // MARK: - Image Classification
    /// - Tag: MLModelSetup
    lazy var classificationRequest: VNCoreMLRequest = {
        do{
            let imageClassification = try VNCoreMLModel(for: ImageCategoryClassifier().model)
            
            let request = VNCoreMLRequest(model: imageClassification, completionHandler: {[weak self] request, error in self?.processClassifications(for: request, error: error)})
            
            request.imageCropAndScaleOption = .centerCrop
            return request
        }catch{
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    /// - Tag: PerformRequests
    func updateClassifications(for image: UIImage) {
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation!)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                /*
                 This handler catches general image processing errors. The `classificationRequest`'s
                 completion handler `processClassifications(_:error:)` catches errors specific
                 to processing that request.
                 */
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    /// - Tag: ProcessClassifications
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                fatalError("Unable to classify image.\n\(error!.localizedDescription)")
            }
            // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
            let classifications = results as! [VNClassificationObservation]
            
            // Only take the most confident result from the classification
            let topClassification = classifications.prefix(1)
            let description = topClassification.map {
                category in
                return String(format: "%@", category.identifier)
            }
            self.category = description.joined()
        }
    }
    
}
