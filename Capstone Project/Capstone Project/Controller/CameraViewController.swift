//
//  ViewController.swift
//  Capstone Project
//
//  Created by Zixuan Zeng on 9/10/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, AVCapturePhotoCaptureDelegate {
    
    // variable for the UIImageView that displays the carema real-time content
    @IBOutlet weak var cameraView: UIImageView!
    // variables for using AVFoundation to do input, output, and preview
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var cameraPreviewlayer: AVCaptureVideoPreviewLayer?
    var photoOutput: AVCapturePhotoOutput?
    var image: UIImage?
    
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
        setupCaptureSession()
        //setupInputOutput()  // Cannot run this on VM simulator since it does not have real camera; this software will crash even though I did error handling on the shutter button
        setupPreviewLayer()
        startRunningCaptureSession()
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
    
    //MARK: - Action for flipping cameras: Do not run this on VM simulator
    @IBAction func flipCamera(_ sender: UIButton) {
        captureSession.stopRunning()
        cameraPreviewlayer?.removeFromSuperlayer()
        
        setupCaptureSession()
        if currentCamera! == backCamera{
            //print(currentCamera)
            currentCamera = frontCamera
        }
        else {
            currentCamera = backCamera
        }
        setupCaptureSession()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
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
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
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
    
    // MARK: - Helper functions following for capturing session of cameras
    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo // Why exclamation point?
        let availableDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: .video, position: .unspecified)
        let devices = availableDevice.devices //back or front
        
        for device in devices {
            
            if device.position == AVCaptureDevice.Position.back{
                backCamera = device
            }else if device.position == AVCaptureDevice.Position.front{
                frontCamera = device
            }
        }
        currentCamera = backCamera
    }
    
    func setupInputOutput(){
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format:[AVVideoCodecKey:AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        }
        catch{
            print(error)
            
        }
    }
    
    func setupPreviewLayer(){
        cameraPreviewlayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewlayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewlayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewlayer?.frame = self.cameraView.frame
        self.view.layer.insertSublayer(cameraPreviewlayer!, at: 0)
    }
    
    func startRunningCaptureSession(){
        captureSession.startRunning()
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
