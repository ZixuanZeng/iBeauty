//
//  ViewController.swift
//  Capstone Project
//
//  Created by Zixuan Zeng on 9/10/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // variable for the UIImageView that displays the carema real-time content
    @IBOutlet weak var cameraView: UIImageView!
    
    // constructor
//    init(cameraView: UIImageView) {
//        self.cameraView = cameraView
//        super.init(nibName: nil, bundle: nil)
//    }
//    // constructor
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    // Create this variable under type of UIImagePickerController so that it can be assigned towards the constructor of this class
    var imagePicker: UIImagePickerController!
    
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
    
    //MARK: - Action for travelling to edit view controller
    // Click this button to jump to edit view controller
    @IBAction func editPhoto(_ sender: UIButton) {
        self.showEditViewController()
    }
    
    // Setup for edit view controller
    @objc func showEditViewController() {
        DispatchQueue.main.async () {
            let EditViewController = self.storyboard!.instantiateViewController(identifier: "editingViewController") as UIViewController
            self.present(EditViewController, animated: true, completion: self.viewDidLoad)
        }
    }
    
    //MARK: - Action for taking pictures
    @IBAction func takePhoto(_ sender: UIButton) {
        //This condition is used for check availability of camera
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true;
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            present(imagePicker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Alert", message: "You don't have a camera for this device", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    // This function conforms to the UIImagePickerController delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage]
        {
            cameraView.image = image as? UIImage
        }
        else
        {
            //error
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
// A global struct to manage the generic functions in all view controllers that apply
struct ViewControllerUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
}
