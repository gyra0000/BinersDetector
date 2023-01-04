//
//  ClassifierManager.swift
//  BinersDetector
//
//  Created by Mataranga, Vlad on 13.11.2022.
//

import CoreML
import UIKit

class ClassifierManager {
    
    static let imageSize: (width: NSNumber, height: NSNumber) = (width: 100, height: 100)
    
    let model: biners_MobileNetV2 = biners_MobileNetV2()
    
    func classifiImage(_ image: UIImage) -> BinerType? {
        
        guard let pixelBuffer = image.preprocess(image: image) else {
            print("can't get pixelBuffer")
            return nil
        }
        
        do {
            let prediction = try model.prediction(input_2: pixelBuffer)
            let value = prediction.Identity[0].doubleValue
            print(value)
            if value < 0 {
                return .bealOrientExpres
            } else {
                return .petzlSmd
            }
        } catch {
            print(error)
            return nil
        }
    }


    
}
