//
//  SVM.swift
//  Capstone Project
//
//  Created by Zixuan Zeng on 11/28/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import Foundation
import CoreML

// This class is created to handle Support Vector Machine model request and continuous training
class SVM {
    // Try to create the model using initializer
    // MARK: - Tabular Classification
    /// - Tag: MLModelSetup
    var svm = SupportVectorMachine().model
    
    static let sharedSVM = SVM()
    
    // Using Singleton for security and non-redundant reference
    private init() {
    }
}
