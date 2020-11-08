//
//  ScrollingViewContent.swift
//  Capstone Project
//  This class is handling the scroll view drawing;
//  Its result is showing in Filter panel
//  Created by Zixuan Zeng on 10/26/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import Foundation
import UIKit

class ScrollingViewContent {
    
    // This function draws all the material needed in the scrolling view
    func drawLabels(subview: UIView!) {
        
        // Following is drawing three labels for categorizing filter types
        let colorFiltersLabel = UILabel(frame: CGRect(x: 120, y: 0, width: 300, height: 100))
        colorFiltersLabel.text = "Color Filters"
        colorFiltersLabel.textColor = .magenta
        colorFiltersLabel.font = UIFont(name: "Helvetica", size: 35)
        subview.addSubview(colorFiltersLabel)
        
        let lightFiltersLabel = UILabel(frame: CGRect(x: 120, y: 200, width: 300, height: 100))
        lightFiltersLabel.text = "Light Filters"
        lightFiltersLabel.textColor = .magenta
        lightFiltersLabel.font = UIFont(name: "Helvetica", size: 35)
        subview.addSubview(lightFiltersLabel)
        
        let detailFiltersLabel = UILabel(frame: CGRect(x: 120, y: 400, width: 300, height: 100))
        detailFiltersLabel.text = "Detail Filters"
        detailFiltersLabel.textColor = .magenta
        detailFiltersLabel.font = UIFont(name: "Helvetica", size: 35)
        subview.addSubview(detailFiltersLabel)
        
    }
    
    // Following functions draw all the buttons needed for all filters: each filter button is identified using a tag number
    func drawKodakFilmFilterButton(button: UIButton!, subview: UIView!) -> UIButton {
        let kodakFilm = UIButton(type: UIButton.ButtonType.roundedRect)
        kodakFilm.frame = CGRect(x: 50, y: 50, width: 300, height: 100)
        kodakFilm.setTitle("Kodak Film", for: .normal)
        kodakFilm.titleLabel?.font = UIFont(name: "SavoyeLetPlain", size: 30)
        kodakFilm.tag = 1
        subview.addSubview(kodakFilm)
        return kodakFilm
    }
    
    func drawInstantFilmFilterButton(button: UIButton!, subview: UIView!) -> UIButton {
        let instantFilm = UIButton(type: UIButton.ButtonType.roundedRect)
        instantFilm.frame = CGRect(x: 50, y: 100, width: 300, height: 100)
        instantFilm.setTitle("Instant Film", for: .normal)
        instantFilm.titleLabel?.font = UIFont(name: "SavoyeLetPlain", size: 30)
        instantFilm.tag = 2
        subview.addSubview(instantFilm)
        return instantFilm
    }
    
    func drawMoreRGBFilterButton(button: UIButton!, subview: UIView!) -> UIButton {
        let moreRGBFilter = UIButton(type: UIButton.ButtonType.roundedRect)
        moreRGBFilter.frame = CGRect(x: 50, y: 150, width: 300, height: 100)
        moreRGBFilter.setTitle("Fujifilm Film", for: .normal)
        moreRGBFilter.titleLabel?.font = UIFont(name: "SavoyeLetPlain", size: 30)
        moreRGBFilter.tag = 3
        subview.addSubview(moreRGBFilter)
        return moreRGBFilter
    }
    
    func drawGammaFilterButton(button: UIButton!, subview: UIView!) -> UIButton {
        let gammaFilter = UIButton(type: UIButton.ButtonType.roundedRect)
        gammaFilter.frame = CGRect(x: 50, y: 275, width: 300, height: 100)
        gammaFilter.setTitle("Gamma", for: .normal)
        gammaFilter.titleLabel?.font = UIFont(name: "SavoyeLetPlain", size: 30)
        gammaFilter.tag = 4
        subview.addSubview(gammaFilter)
        return gammaFilter
    }
    // Tone curve is about to adjust brightness and contrast so it resides in lights filters
    func drawToneCurveFilterButton(button: UIButton!, subview: UIView!) -> UIButton {
        let toneCurveFilter = UIButton(type: UIButton.ButtonType.roundedRect)
        toneCurveFilter.frame = CGRect(x: 50, y: 350, width: 300, height: 100)
        toneCurveFilter.setTitle("Tone Curve", for: .normal)
        toneCurveFilter.titleLabel?.font = UIFont(name: "SavoyeLetPlain", size: 30)
        toneCurveFilter.tag = 5
        subview.addSubview(toneCurveFilter)
        return toneCurveFilter
    }
    
    func drawSCurveFilterButton(button: UIButton!, subview: UIView!) -> UIButton {
        let sCurveFilter = UIButton(type: UIButton.ButtonType.roundedRect)
        sCurveFilter.frame = CGRect(x: 50, y: 475, width: 300, height: 100)
        sCurveFilter.setTitle("S Curve", for: .normal)
        sCurveFilter.titleLabel?.font = UIFont(name: "SavoyeLetPlain", size: 30)
        sCurveFilter.tag = 6
        subview.addSubview(sCurveFilter)
        return sCurveFilter
    }
}
