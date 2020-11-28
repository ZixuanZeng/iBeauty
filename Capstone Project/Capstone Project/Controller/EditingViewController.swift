//
//  ViewController.swift
//  Capstone Project
//  
//  Created by Zixuan Zeng on 9/10/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // instance for sending out photo data to other view controllers (To hold and store image data for future use)
    var photo: Photo!
    // variable for displaying images inside UIImageView
    @IBOutlet var imageView: UIImageView!
    // variable for holding temporary image data for the 'cancel' action
    var tempImage: UIImage!
    // Connection for UIToolBar object
    @IBOutlet var adjustmentBar: UIToolbar!
            
    // This variable holds the value that determines which adjustment bar button is pressed
    var adjustmentMode: Int!
            
    // These are for all the models objects
    let editPhoto = PhotoEditing()
    let controller = ControllerDisplay()
    let scrollingView = ScrollingViewContent()
    let dataHandler = DataHandler()
    let imageClassifier = NeuralNetwork()
    // Getting SVM model singleton here
    let adjustmentClassifier = SVM.sharedSVM.svm
    
    // Following variables are to hold number of current objects in each entity (table) so that it can assign correct photo adjustment ID to every adjustment
    var imageID: Int?
    var categoryID: Int?
    var filterAdjustmentID: Int? = nil
    var lightAdjustmentID: Int? = nil
    var colorAdjustmentID: Int? = nil
    var detailAdjustmentID: Int? = nil
    
    // Initialize the structs for adjustment parameter values holding
    var lightValue = light()
    var colorValue = color()
    var detailValue = details()
    var filterValue = filters()
    
    // all the variables for tool bar buttons
    @IBOutlet var exposureButton: UIBarButtonItem!
    
    @IBOutlet var colorButton: UIBarButtonItem!
    
    @IBOutlet var detailsButton: UIBarButtonItem!
    
    // variable attribute for the adjustment sub-view
    @IBOutlet var adjustmentView: UIView!
    
    // variable attribute for the filter adjustment sub-view
    @IBOutlet var filterAdjustmentSubview: UIView!
    
    @IBOutlet var filtersLabel: UILabel!
    
    @IBOutlet var filtersScrollSubview: UIScrollView!
    
    @IBOutlet var filtersContentSubview: UIView!
    
    
    // Below are all the variables for the buttons and labels inside adjustment sub-view and all the buttons event handlers
    @IBOutlet var buttonOne: UIButton!
    
    @IBOutlet var buttonTwo: UIButton!
    
    @IBOutlet var buttonThree: UIButton!
    
    @IBOutlet var labelOne: UILabel!
    
    @IBOutlet var labelTwo: UILabel!
    
    @IBOutlet var labelThree: UILabel!
    
    @IBOutlet var sliderOne: UISlider!
    
    @IBOutlet var sliderTwo: UISlider!
    
    @IBOutlet var sliderThree: UISlider!
    
    @IBOutlet var kodakFilmFilter: UIButton!
    
    @IBOutlet var instantFilmFilter: UIButton!
    
    @IBOutlet var moreRGBFilter: UIButton!
    
    @IBOutlet var gammaFilter: UIButton!
    
    @IBOutlet var toneCurveFilter: UIButton!
    
    @IBOutlet var sCurveFilter: UIButton!
    
    @IBAction func buttonOneClick(_ sender: UIButton) {
        if self.imageView.image != nil {
            if adjustmentMode == BarButtons.light.rawValue {
                // Only when light adjustment has this button, in my design, it does not have this button
            }
            else if adjustmentMode == BarButtons.color.rawValue {
                
            }
            else if adjustmentMode == BarButtons.details.rawValue {
                imageView.image = editPhoto.addVignette(image: imageView.image!)
                // Set the adjustment boolean value to the struct instance; prepare the use for data storage
                detailValue.buttonOne = 1.0
            }
        } else {
            alertNilImage()
        }
    }
    
    @IBAction func buttonTwoClick(_ sender: UIButton) {
        if self.imageView.image != nil {
            if adjustmentMode == BarButtons.light.rawValue {
                // This is for future UI upgrade only
            }
            else if adjustmentMode == BarButtons.color.rawValue {
                imageView.image = editPhoto.convertToGrayScale(image: imageView.image!)
                colorValue.button = 1.0
            }
            else if adjustmentMode == BarButtons.details.rawValue {
                
            }
        } else {
            alertNilImage()
        }
    }
    
    @IBAction func buttonThreeClick(_ sender: UIButton) {
        if self.imageView.image != nil {
            if adjustmentMode == BarButtons.light.rawValue {
                
            }
            else if adjustmentMode == BarButtons.color.rawValue {
                
            }
            else if adjustmentMode == BarButtons.details.rawValue {
                imageView.image = editPhoto.reduceNoise(image: imageView.image!)
                detailValue.buttonTwo = 1.0
            }
        } else {
            alertNilImage()
        }
    }
    
    @IBAction func sliderOneChange(_ sender: UISlider) {
        if self.imageView.image != nil {
            if adjustmentMode == BarButtons.light.rawValue {
                imageView.image = editPhoto.adjustExposure(image: imageView.image!, value: Int(sender.value))
                // // Set the adjustment float value to the struct instance; prepare the use for data storage
                lightValue.sliderOne = sender.value
            }
            else if adjustmentMode == BarButtons.color.rawValue {
                imageView.image = editPhoto.adjustHue(image: imageView.image!, value: Int(sender.value))
                colorValue.sliderOne = sender.value
            }
            else if adjustmentMode == BarButtons.details.rawValue {
                imageView.image = editPhoto.adjustContrast(image: imageView.image!, value: sender.value)
                detailValue.sliderOne = sender.value
            }
        } else {
            alertNilImage()
        }
    }
    
    @IBAction func sliderTwoChange(_ sender: UISlider) {
        if self.imageView.image != nil {
            if adjustmentMode == BarButtons.light.rawValue {
                imageView.image = editPhoto.adjustHighlightAndShadow(image: imageView.image!, highlightAmount: Int(sender.value), shadowAmount: Int(sliderThree.value))
                lightValue.sliderTwo = sender.value
            }
            else if adjustmentMode == BarButtons.color.rawValue {
                imageView.image = editPhoto.adjustTemperatureAndTint(image: imageView.image!, temperature: sender.value)
                colorValue.sliderTwo = sender.value
            }
            else if adjustmentMode == BarButtons.details.rawValue {
                imageView.image = editPhoto.adjustSharpness(image: imageView.image!, radiusAmount: Int(sender.value), intensityAmount: Int(sliderThree.value))
                detailValue.sliderThree = sender.value
            }
        } else {
            alertNilImage()
        }
    }
    
    @IBAction func sliderThreeChange(_ sender: UISlider) {
        if self.imageView.image != nil {
            if adjustmentMode == BarButtons.light.rawValue {
                imageView.image = editPhoto.adjustHighlightAndShadow(image: imageView.image!, highlightAmount: Int(sliderTwo.value), shadowAmount: Int(sender.value))
                lightValue.sliderThree = sender.value
            }
            else if adjustmentMode == BarButtons.color.rawValue {
                imageView.image = editPhoto.adjustSaturation(image: imageView.image!, value: Int(sender.value))
                colorValue.sliderThree = sender.value
            }
            else if adjustmentMode == BarButtons.color.rawValue {
                imageView.image = editPhoto.adjustSharpness(image: imageView.image!, radiusAmount: Int(sliderTwo.value), intensityAmount: Int(sender.value))
                detailValue.sliderThree = sender.value
            }
        } else {
            alertNilImage()
        }
    }
    
    // This event handler handles all the buttons actions inside filter adjustment view
    @IBAction func filterButtonsClicked(sender: UIButton) {
        if self.imageView.image != nil {
            if sender.tag == 1 {
                self.imageView.image = editPhoto.addFilmFilter(image: self.imageView.image!)
                filterValue.buttonOne = 1.0
            }
            else if sender.tag == 2 {
                self.imageView.image = editPhoto.addInstantFilmFilter(image: self.imageView.image!)
                filterValue.buttonTwo = 1.0
            }
            else if sender.tag == 3 {
                self.imageView.image = editPhoto.addFujifilmFilter(image: self.imageView.image!)
                filterValue.buttonThree = 1.0
            }
            else if sender.tag == 4 {
                self.imageView.image = editPhoto.addGammaLight(image: self.imageView.image!)
                filterValue.buttonFour = 1.0
            }
            else if sender.tag == 5 {
                self.imageView.image = editPhoto.addToneCurve(image: self.imageView.image!)
                filterValue.buttonFive = 1.0
            }
            else{
                self.imageView.image = editPhoto.addRGBToneCurve(image: self.imageView.image!)
                filterValue.buttonSix = 1.0
            }
        } else {
            alertNilImage()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //This is to hide navigation bar in main view controller
        navigationController?.setNavigationBarHidden(true, animated: animated)
        // Disable autorotation & lock in portrait mode
        ViewControllerUtility.lockOrientation(.portrait)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let mainview = self.view
        mainview!.addSubview(filterAdjustmentSubview)
        adjustmentView.isHidden = true
        adjustmentMode = 0
        filterAdjustmentSubview.isHidden = true
        filterAdjustmentSubview.isOpaque = true
        scrollingView.drawLabels(subview: filtersScrollSubview)
        kodakFilmFilter = scrollingView.drawKodakFilmFilterButton(button: self.kodakFilmFilter, subview: filtersScrollSubview)
        instantFilmFilter = scrollingView.drawInstantFilmFilterButton(button: self.instantFilmFilter, subview: filtersScrollSubview)
        moreRGBFilter = scrollingView.drawMoreRGBFilterButton(button: self.moreRGBFilter, subview: filtersScrollSubview)
        gammaFilter = scrollingView.drawGammaFilterButton(button: self.gammaFilter, subview: filtersScrollSubview)
        toneCurveFilter = scrollingView.drawToneCurveFilterButton(button: self.toneCurveFilter, subview: filtersScrollSubview)
        sCurveFilter = scrollingView.drawSCurveFilterButton(button: self.sCurveFilter, subview: filtersScrollSubview)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        ViewControllerUtility.lockOrientation(.all)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Below is all the button methods for displaying different views of adjustment*/
    //MARK: - Action for returning to carema view controller
    @IBAction func returnToCaremaViewController(_ sender: UIButton) {
        self.showCaremaViewController()
    }
    
    // Setup for returning to carema view controller
    @objc func showCaremaViewController() {
        DispatchQueue.main.async () {
            let CaremaViewController = self.storyboard!.instantiateViewController(identifier: "cameraViewController") as UIViewController
            self.present(CaremaViewController, animated: true, completion: self.viewDidLoad)
        }
    }
    
    //MARK: - Action for jumping to exposure editing view
    @IBAction func navigateToExposureEditingView(_ sender: UIBarButtonItem) {
        adjustmentView.isHidden = false
        adjustmentBar.isHidden = true
        switcher(tag: sender.tag)
        adjustmentMode = BarButtons.light.rawValue
        tempImage = imageView.image
    }
    
    
    //MARK: - Action for jumping to color editing view
    @IBAction func navigateToColorEditingView(_ sender: UIBarButtonItem) {
        adjustmentView.isHidden = false
        adjustmentBar.isHidden = true
        switcher(tag: sender.tag)
        adjustmentMode = BarButtons.color.rawValue
        tempImage = imageView.image
    }

    //MARK: - Action for jumping to Details editing view
    @IBAction func navigateToDetailsEditingView(_ sender: UIBarButtonItem) {
        adjustmentView.isHidden = false
        adjustmentBar.isHidden = true
        switcher(tag: sender.tag)
        adjustmentMode = BarButtons.details.rawValue
        tempImage = imageView.image
    }
    
    //MARK: - Action for jumping to Filters editing view
    @IBAction func navigateToFilterEditingView(_ sender: UIBarButtonItem) {
        filterAdjustmentSubview.isHidden = false
        adjustmentBar.isHidden = true
        adjustmentMode = BarButtons.filters.rawValue
        kodakFilmFilter.addTarget(self, action: #selector(filterButtonsClicked(sender:)), for: .touchUpInside) // Add an event listener here
        instantFilmFilter.addTarget(self, action: #selector(filterButtonsClicked(sender:)), for: .touchUpInside)
        moreRGBFilter.addTarget(self, action: #selector(filterButtonsClicked(sender:)), for: .touchUpInside)
        gammaFilter.addTarget(self, action: #selector(filterButtonsClicked(sender:)), for: .touchUpInside)
        toneCurveFilter.addTarget(self, action: #selector(filterButtonsClicked(sender:)), for: .touchUpInside)
        sCurveFilter.addTarget(self, action: #selector(filterButtonsClicked(sender:)), for: .touchUpInside)
        tempImage = imageView.image
    }
    
    //MARK: - Action for performing auto/smart-editing (Version 1 for further development)
    @IBAction func performSmartEditing(_ sender: UIBarButtonItem) {
        if imageClassifier.category == "Landscape" {
            imageView.image = editPhoto.addFilmFilter(image: imageView.image!)
            imageView.image = editPhoto.addToneCurve(image: imageView.image!)
        }
        else if imageClassifier.category == "Portrait" {
            imageView.image = editPhoto.addInstantFilmFilter(image: imageView.image!)
            imageView.image = editPhoto.addGammaLight(image: imageView.image!)
        }
        else {
            imageView.image = editPhoto.convertToGrayScale(image: imageView.image!)
        }
    }
    
    //MARK: - Action for jumping back to editing view
    @IBAction func saveToEditingView(sender: UIButton){
        adjustmentView.isHidden = true
        adjustmentBar.isHidden = false
        if adjustmentMode == BarButtons.light.rawValue {
            lightAdjustmentID = dataHandler.getNumberOfObject(_entityName: "LightParameters") + 1
            dataHandler.saveLightParameters(lightID: lightAdjustmentID!, sliderOne: lightValue.sliderOne!, sliderTwo: lightValue.sliderTwo!, sliderThree: lightValue.sliderThree!)
        }
        else if adjustmentMode == BarButtons.color.rawValue {
            colorAdjustmentID = dataHandler.getNumberOfObject(_entityName: "ColorParameters") + 1
            dataHandler.saveColorParameters(colorID: colorAdjustmentID!, button: colorValue.button!, sliderOne: colorValue.sliderOne!, sliderTwo: colorValue.sliderTwo!, sliderThree: colorValue.sliderThree!)
        }
        else if adjustmentMode == BarButtons.details.rawValue {
            detailAdjustmentID = dataHandler.getNumberOfObject(_entityName: "DetailParameters") + 1
            dataHandler.saveDetailParameters(detailID: detailAdjustmentID!, buttonOne: detailValue.buttonOne!, buttonTwo: detailValue.buttonTwo!, sliderOne: detailValue.sliderOne!, sliderTwo: detailValue.sliderTwo!, sliderThree: detailValue.sliderThree!)
        }
    }
    
    @IBAction func cancelToEditingView(sender: UIButton){
        imageView.image = tempImage
        adjustmentView.isHidden = true
        adjustmentBar.isHidden = false
        lightAdjustmentID = nil; colorAdjustmentID = nil; detailAdjustmentID = nil
    }
    
    //MARK: - Action for jumping back to editing view from filters subview
    // Below two event handlers for two buttons in filters subview
    @IBAction func saveAndExitToEditingView(_ sender: UIButton) {
        filterAdjustmentSubview.isHidden = true
        adjustmentBar.isHidden = false
        // This is to generate an ID in ascending order like the primary key in data base
        filterAdjustmentID = dataHandler.getNumberOfObject(_entityName: "FilterParameters") + 1
        dataHandler.saveFilterParameters(filterID: filterAdjustmentID!, buttonOne: filterValue.buttonOne!, buttonTwo: filterValue.buttonTwo!, buttonThree: filterValue.buttonThree!, buttonFour: filterValue.buttonFour!, buttonFive: filterValue.buttonFive!, buttonSix: filterValue.buttonSix!)
    }
    
    @IBAction func cancelAndExitToEditingView(_ sender: UIButton) {
        imageView.image = tempImage
        filterAdjustmentSubview.isHidden = true
        adjustmentBar.isHidden = false
        filterAdjustmentID = nil
    }
    

    /* Above are all the button methods for displaying different views in adjustment panel*/
    
    // This function determines which adjustment type is and then determines buttons and sliders functions on each sub-view (Only control first three tab buttons)
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
            labelTwo.isHidden = false
            labelTwo.text = "Temperature"
            labelThree.isHidden = false
            labelThree.text = "Saturation"
            sliderOne.isHidden = false
            sliderOne.value = 50
            sliderTwo.isHidden = false
            sliderTwo.value = 50
            sliderThree.isHidden = false
            sliderThree.value = 0
        case 3:
            buttonOne.isHidden = false
            buttonOne.setTitle("Vignette", for: .normal)
            buttonTwo.isHidden = true
            buttonThree.isHidden = false
            buttonThree.setTitle("NR", for: .normal)
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
    
    //MARK: - Action for fetching images from device's album
    @IBAction func fetchImages(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true;
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - Action for displaying images from device's album
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage]
        {
            imageView.image = image as? UIImage
        }
        else
        {
            //error
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Alert message window for nil image inside UIImageView
    func alertNilImage() {
        let alert = UIAlertController(title: "Alert", message: "Please import a photo from Album!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cacel", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Import", style: UIAlertAction.Style.default, handler: alertHandlerWithImportPhotoFuntion(alert:)))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Alert handler for handling nil image in UIImageView, this one allows importing images
    func alertHandlerWithImportPhotoFuntion(alert: UIAlertAction!) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true;
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - Action for saving post-edit photos to photo album
    @IBAction func saveToPhotoAlbum(_ sender: UIButton) {
        savePhoto(finalImage: self.imageView.image!)
        imageID = dataHandler.getNumberOfObject(_entityName: "EditedImage") + 1
        if imageClassifier.category == "Landscape" {
            categoryID = 1
        }
        else if imageClassifier.category == "Portrait" {
            categoryID = 2
        }
        else{
            categoryID = 3
        }
        // Save all necessary data into Core Data using model built
        if lightAdjustmentID != nil || colorAdjustmentID != nil || detailAdjustmentID != nil || filterAdjustmentID != nil {
            dataHandler.saveAllAdjustmentParameters(imageID: imageID, categoryID: categoryID, lightID: lightAdjustmentID, colorID: colorAdjustmentID, detailID: detailAdjustmentID, filterID: filterAdjustmentID)
        }
        dataHandler.saveImageCategory(categoryID: categoryID!)
        // Remember to reset all the parameters to original position
        lightValue.reset()
        colorValue.reset()
        detailValue.reset()
        filterValue.reset()
    }
    
    //MARK: - Save function for saving all edited photos to photo album
    func savePhoto(finalImage: UIImage!) {
        UIImageWriteToSavedPhotosAlbum(finalImage, nil, nil, nil)
    }
    
}

// enum data structure to hold bar buttons info
enum BarButtons: Int {
    case light = 1
    case color = 2
    case details = 3
    case filters = 4
    case smart = 5
}
