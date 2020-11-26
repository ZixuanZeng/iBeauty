//
//  InputData.swift
//  Capstone Project
//
//  Created by Zixuan Zeng on 11/25/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import Foundation

// This file has struct data structures to hold and clean all the input data

// structs for holding temporary parameter values from each adjustment panel and for storage to Core Data
struct light {
    var sliderOne: Float? = 50.0
    var sliderTwo: Float? = 0.0
    var sliderThree: Float? = 0.0
    
    mutating func reset(){
        sliderOne = 50.0
        sliderTwo = 0.0
        sliderThree = 0.0
    }
}

struct color {
    var button: Float? = 0.0 // The reason of using float data type instead of boolean is that float is easier for machine learning model fitting during training
    var sliderOne: Float? = 50.0
    var sliderTwo: Float? = 50.0
    var sliderThree: Float? = 0.0
    
    mutating func reset(){
        button = 0.0
        sliderOne = 50.0
        sliderTwo = 50.0
        sliderThree = 50.0
    }
}

struct details {
    var buttonOne: Float? = 0.0
    var buttonTwo: Float? = 0.0
    var sliderOne: Float? = 50.0
    var sliderTwo: Float? = 0.0
    var sliderThree: Float? = 0.0
    
    mutating func reset(){
        buttonOne = 0.0
        buttonTwo = 0.0
        sliderOne = 50.0
        sliderTwo = 0.0
        sliderThree = 0.0
    }
}

struct filters {
    var buttonOne: Float? = 0.0
    var buttonTwo: Float? = 0.0
    var buttonThree: Float? = 0.0
    var buttonFour: Float? = 0.0
    var buttonFive: Float? = 0.0
    var buttonSix: Float? = 0.0
    
    mutating func reset(){
        buttonOne = 0.0
        buttonTwo = 0.0
        buttonThree = 0.0
        buttonFour = 0.0
        buttonFive = 0.0
        buttonSix = 0.0
    }
}

