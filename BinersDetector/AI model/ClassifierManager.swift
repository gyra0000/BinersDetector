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
            let prediction = try model.prediction(input_4: pixelBuffer)
            guard let ubp = try? UnsafeBufferPointer<Float>(prediction.Identity) else  {
                return nil
            }
            let values = Array(ubp)
            guard  let max = values.max(), let index = values.firstIndex(of: max) else {
                return nil
            }
            
            let list: [BinerType] = [.ctAerialProSG, .bealOrientExpres, .petzlSmd, .petzlDjinnBG]
            
            return list[index]
        
        } catch {
            print(error)
            return nil
        }
    }


    
}
