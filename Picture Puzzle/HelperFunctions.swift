//
//  HelperFunctions.swift
//  PicturePuzzle
//
//  Created by Paul Way on 3/5/23.
//

import Foundation
import CoreGraphics
import SwiftUI

func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect) -> UIImage?
{
    var x = inputImage.size.width/2 - 60
    var y = inputImage.size.height/2 - 60
    x += cropRect.minX
    y += cropRect.minY
    
    let cropZone = CGRect(x:x,
                          y:y,
                          width: 120 ,
                          height: 120 )
    return crop(inputImage, toRect: cropZone)
}

func cropSquare(_ inputImage: UIImage) -> UIImage?
{
    var cropZone = CGRect()
    let difference = abs(inputImage.size.width - inputImage.size.height)
    if inputImage.size.width > inputImage.size.height{
        cropZone = CGRect(x:difference, 
                          y:0,
                          width:inputImage.size.height ,
                          height:inputImage.size.height )
    }
    else {
        cropZone = CGRect(x:0,
                          y:0,
                          width:inputImage.size.width,
                          height:inputImage.size.width)
    }
    print(cropZone)
    return crop(inputImage, toRect: cropZone)
}

func crop(_ inputImage: UIImage, toRect cropRect: CGRect) -> UIImage?
{
    guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropRect)
    else {
        return nil
    }
    let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
    return croppedImage
}

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
//    let size = image.size
    
//    let widthRatio  = targetSize.width  / size.width
//    let heightRatio = targetSize.height / size.height
//
//    var newSize: CGSize
//    if(widthRatio > heightRatio) {
//        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
//    } else {
//        newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
//    }
    
    let rect = CGRect(origin: .zero, size: targetSize)
    
    UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
}
