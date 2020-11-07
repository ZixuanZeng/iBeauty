//
//  ControllerDisplay.swift
//  Capstone Project
//
//  Created by Zixuan Zeng on 10/9/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import Foundation
import UIKit

/* This class is the brain of view controller display logic*/
class ControllerDisplay {
    // declare all variables for buttons, sliders and labels
    var buttonOne: UIButton!
    var buttonTwo: UIButton!
    var buttonThree: UIButton!
    var labelOne: UILabel!
    var labelTwo: UILabel!
    var labelThree: UILabel!
    var sliderOne: UISlider!
    var sliderTwo: UISlider!
    var sliderThree: UISlider!
    
    // This function determines which adjustment type is and then determines buttons and sliders functions
    func switcher(tag: Int) {
        switch tag {
        case 1:
            buttonOne.isHidden = true
            buttonTwo.isHidden = true
            buttonThree.isHidden = true
            labelOne.isHidden = false
            labelOne.text = "Exposure"
            labelTwo.isHidden = false
            labelTwo.text = "Highlight"
            labelThree.isHidden = false
            labelThree.text = "Shadow"
            sliderOne.isHidden = false
            sliderOne.value = 50
            sliderTwo.isHidden = false
            sliderTwo.value = 0
            sliderThree.isHidden = false
            sliderThree.value = 0
        case 2:
            buttonOne.isHidden = true
            buttonTwo.isHidden = false
            buttonTwo.setTitle("B&W", for: .normal)
            buttonThree.isHidden = true
            labelOne.isHidden = false
            labelOne.text = "Hue"
            labelTwo.isHidden = true
            labelThree.isHidden = false
            labelThree.text = "Saturation"
            sliderOne.isHidden = false
            sliderOne.value = 50
            sliderTwo.isHidden = true
            sliderThree.isHidden = false
            sliderThree.value = 0
        case 3:
            buttonOne.isHidden = true
            buttonTwo.isHidden = false
            buttonTwo.setTitle("NR", for: .normal)
            buttonThree.isHidden = true
            labelOne.isHidden = false
            labelOne.text = "Contrast"
            labelTwo.isHidden = false
            labelTwo.text = "Sharpness Radius"
            labelThree.isHidden = false
            labelThree.text = "Sharpness Intensity"
            sliderOne.isHidden = false
            sliderOne.value = 50
            sliderTwo.isHidden = false
            sliderTwo.value = 0
            sliderThree.isHidden = false
            sliderThree.value = 0
        default:
            buttonOne.isHidden = true
            buttonTwo.isHidden = true
            buttonThree.isHidden = true
            labelOne.isHidden = true
            labelTwo.isHidden = true
            labelThree.isHidden = true
            sliderOne.isHidden = true
            sliderTwo.isHidden = true
            sliderThree.isHidden = true
        }
    }
}
