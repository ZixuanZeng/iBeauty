//
//  PhotoEditing.swift
//  Capstone Project
//
//  Created by Zixuan Zeng on 10/3/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//
// Classes including: CIContext, CIFilter, CIImage, and CIColor; More advanced: CIDetector: to detect objects

import Foundation
import UIKit

/* This class implements the Core Image and MATLAB models to edit photos*/

internal class PhotoEditing {
    
    // define context globally for reuse
    //let eagleContext = CVEAGLContext(api: .openGLES3)
    lazy var context = CIContext(options: [CIContextOption.cacheIntermediates: true, CIContextOption.priorityRequestLow: false])
    //lazy var context = CIContext(eaglContext: eagleContext!)
    //let data = Kernel().createColorCubeData()
    
    //MARK: - Action for converting to black and white
    func convertToGrayScale(image: UIImage) -> UIImage? {
        
        // 1 method: Use CIFilter
        if let filter = CIFilter(name: "CIPhotoEffectNoir") {
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            if let output = filter.outputImage {
                if let newImage = context.createCGImage(output, from: output.extent) {
                    return UIImage(cgImage: newImage)
                }
            }
        }
        return nil
        
        // 2 method: Use CGColorSpaceCreateDeviceGray
        /*
        // Create image rectangle with current image width/height
        let imageRect:CGRect = CGRect(x:0, y:0, width:image.size.width, height: image.size.height)

        // Grayscale color space
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height

        // Create bitmap content with current image size and grayscale colorspace
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)

        // Draw image into current context, with specified rectangle
        // using previously defined context (with grayscale colorspace)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context?.draw(image.cgImage!, in: imageRect)
        let imageRef = context!.makeImage()

        // Create a new UIImage object
        let newImage = UIImage(cgImage: imageRef!)

        return newImage
        */
    }
    
    //MARK: - Action for doing contrast to an image
    func adjustContrast(image: UIImage, value: Float) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        // value 2 means contrast, 0 is desaturate, < 1
        let parameters = [
            "inputContrast": NSNumber(value: (value / 50))
        ]
        let outputImage = inputImage.applyingFilter("CIColorControls", parameters: parameters)
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    
    //MARK: - Action for changing exposure to an image
    func adjustExposure(image: UIImage, value: Int) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        // value should between -5 to 5 in terms of exposure
        let parameters = [
            "inputEV": NSNumber(value: ((value - 50) / 10))
        ]
        let outputImage = inputImage.applyingFilter("CIExposureAdjust", parameters: parameters)
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    
    //MARK: - Action for adjusting hue to an image
    func adjustHue(image: UIImage, value: Int) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        // value should between -49 to 50 to adjust hue
        let parameters = [
            "inputAngle": NSNumber(value: (value - 50))
        ]
        let outputImage = inputImage.applyingFilter("CIHueAdjust", parameters: parameters)
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    
    //MARK: - Action for adjusting saturation to an image
    func adjustSaturation(image: UIImage, value: Int) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        // value should between -49 to 50 in terms of saturation
        let parameters = [
            "inputAmount": NSNumber(value: (value / 50))
        ]
        let outputImage = inputImage.applyingFilter("CIVibrance", parameters: parameters)
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    
    //MARK: - Action for adjusting highlights and shadows to an image
    func adjustHighlightAndShadow(image: UIImage, highlightAmount: Int, shadowAmount: Int) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        // value should between valid numbers for both adjustments: 0 - 2
        let parameters = [
            "inputHighlightAmount": NSNumber(value: (highlightAmount / 50)),
            "inputShadowAmount": NSNumber(value: (shadowAmount / 50))
        ]
        let outputImage = inputImage.applyingFilter("CIHighlightShadowAdjust", parameters: parameters)
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    
    //MARK: - Action for adjusting edge sharpness to an image
    func adjustSharpness(image: UIImage, radiusAmount: Int, intensityAmount: Int) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        // value should between valid numbers for both adjustments: 0 - 2
        let parameters = [
            "inputRadius": NSNumber(value: (radiusAmount / 50)),
            "inputIntensity": NSNumber(value: (intensityAmount / 50))
        ]
        let outputImage = inputImage.applyingFilter("CIUnsharpMask", parameters: parameters)
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    
    //MARK: - Action for removing noise to an image
    func reduceNoise(image: UIImage) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        // values of parameters are fixed for the best performance
        let parameters = [
            "inputNoiseLevel": NSNumber(value: 0.5),
            "inputSharpness": NSNumber(value: 0.4)
        ]
        let outputImage = inputImage.applyingFilter("CINoiseReduction", parameters: parameters)
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    
    //MARK: - Action for adjusting temperature and tint to an image
    func adjustTemperatureAndTint(image: UIImage, temperature: Float) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        // values of parameters are CIVector
        let tempVector = CIVector(cgPoint: CGPoint(x: Int(truncating: NSNumber(value:(temperature * 130))), y:0))
        let tintVector = CIVector(cgPoint: CGPoint(x: 6500, y: 0))  // no tint editing option; so set it to default value
        // put all parameters in a dictionary
        let parameters = [
            "inputNeutral": tempVector,
            "inputTargetNeutral": tintVector
        ]
        let outputImage = inputImage.applyingFilter("CITemperatureAndTint", parameters: parameters)
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    
    //MARK: - Action for adding vignette to an image
    func addVignette(image: UIImage) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        // put all parameters in a dictionary
        let parameters = [
            "inputRadius": NSNumber(value: 1.0),
            "inputIntensity": NSNumber(value: 5.0)
        ]
        let outputImage = inputImage.applyingFilter("CIVignette", parameters: parameters)
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    // Colors:
    //CIPhotoEffectChrome
    //MARK: - Action for adding kodak film filter to an image
    func addFilmFilter(image: UIImage) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        
        let outputImage = inputImage.applyingFilter("CIPhotoEffectChrome")
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    
    //CIPhotoEffectInstant
    //MARK: - Action for adding instant film filter to an image
    func addInstantFilmFilter(image: UIImage) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        
        let outputImage = inputImage.applyingFilter("CIPhotoEffectInstant")
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    //CIColorCrossPolynomial
    //MARK: - Action for adding fujifilm filter on an image
    func addFujifilmFilter(image: UIImage) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        // put all parameters in a dictionary
        let redFloatArray: [CGFloat] = [1, 0, 0, 0, 0, 0, 0, 0, 0]
        let vectorRed = CIVector(values: redFloatArray, count: Int(UInt(redFloatArray.count)))
        
        let greenFloatArray: [CGFloat] = [0, 1.3, 0, 0, 0, 0, 0, 0, 0]
        let vectorGreen = CIVector(values: greenFloatArray, count: Int(UInt(greenFloatArray.count)))
        
        let blueFloatArray: [CGFloat] = [0, 0, 1.2, 0, 0, 0, 0, 0, 0]
        let vectorBlue = CIVector(values: blueFloatArray, count: Int(UInt(blueFloatArray.count)))
        
        let parameters = [
            "inputRedCoefficients": vectorRed,
            "inputGreenCoefficients": vectorGreen,
            "inputBlueCoefficients": vectorBlue
        ]
        let outputImage = inputImage.applyingFilter("CIColorCrossPolynomial", parameters: parameters)
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    //Lights:
    //CIGammaAdjust
    //MARK: - Action for adding gamma light on an image
    func addGammaLight(image: UIImage) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        
        // put all parameters in a dictionary
        let parameters = [
            "inputPower": NSNumber(value: 1.85)
        ]
        let outputImage = inputImage.applyingFilter("CIGammaAdjust", parameters: parameters)
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    
    //CILinearToSRGBToneCurve: Learn how to write myself
    //MARK: - Action for adding tone curve filter on an image
    func addToneCurve(image: UIImage) -> UIImage {
        // Covert to CIImage
        let inputImage = CIImage(image: image)!
        
        let outputImage = inputImage.applyingFilter("CILinearToSRGBToneCurve")
        
        //draw context with defined parameters
        let newImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: newImage)
    }
    
    //Details:
    // DIY S Curve
    //MARK: - Action for adding RGB tone curve filter on an image
    func addRGBToneCurve(image: UIImage) -> UIImage {
        let inputImage = CIImage(image: image)!
        // vector variables for RGB points along y-axis of the image
        let inputRedValues = CIVector(values: [0.0, 0.20, 0.5, 0.80, 1.0], count: 5)
        let inputGreenValues = CIVector(values: [0.0, 0.20, 0.5, 0.80, 1.0], count: 5)
        let inputBlueValues = CIVector(values: [0.0, 0.20, 0.5, 0.80, 1.0], count: 5)
        // All the parameters needed for the filter implementation (x-axis 5 points)
        let redParameter = ["inputPoint0": CIVector(x: 0.0, y: inputRedValues.value(at: 0)),
                            "inputPoint1": CIVector(x: 0.25, y: inputRedValues.value(at: 1)),
                            "inputPoint2": CIVector(x: 0.5, y: inputRedValues.value(at: 2)),
                            "inputPoint3": CIVector(x: 0.75, y: inputRedValues.value(at: 3)),
                            "inputPoint4": CIVector(x: 1.0, y: inputRedValues.value(at: 4))]
        
        let greenParameter = ["inputPoint0": CIVector(x: 0.0, y: inputGreenValues.value(at: 0)),
                              "inputPoint1": CIVector(x: 0.25, y: inputGreenValues.value(at: 1)),
                              "inputPoint2": CIVector(x: 0.5, y: inputGreenValues.value(at: 2)),
                              "inputPoint3": CIVector(x: 0.75, y: inputGreenValues.value(at: 3)),
                              "inputPoint4": CIVector(x: 1.0, y: inputGreenValues.value(at: 4))]
        
        let blueParameter = ["inputPoint0": CIVector(x: 0.0, y: inputBlueValues.value(at: 0)),
                              "inputPoint1": CIVector(x: 0.25, y: inputBlueValues.value(at: 1)),
                              "inputPoint2": CIVector(x: 0.5, y: inputBlueValues.value(at: 2)),
                              "inputPoint3": CIVector(x: 0.75, y: inputBlueValues.value(at: 3)),
                              "inputPoint4": CIVector(x: 1.0, y: inputBlueValues.value(at: 4))]
        let outputRedImage = inputImage.applyingFilter("CIToneCurve", parameters: redParameter)
        let outputGreenImage = outputRedImage.applyingFilter("CIToneCurve", parameters: greenParameter)
        let outputFinalAndBlueImage = outputGreenImage.applyingFilter("CIToneCurve", parameters: blueParameter)
        //draw context with defined parameters
        let newImage = context.createCGImage(outputFinalAndBlueImage, from: outputFinalAndBlueImage.extent)!
        return UIImage(cgImage: newImage)
    }
}
