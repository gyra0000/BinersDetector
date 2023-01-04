//
//  UIImage+Extension.swift
//  BinersDetector
//
//  Created by Mataranga, Vlad on 13.11.2022.
//

import UIKit
import Foundation
import CoreML

extension UIImage {
    
    func resizeImage(newSize: CGSize = CGSize(width: 100, height: 100)) -> UIImage? {
        
        UIGraphicsBeginImageContext(newSize)
        draw(in: CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    public func pixelData() -> [UInt8]? {
            let dataSize = size.width * size.height * 4
            var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let context = CGContext(data: &pixelData, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 4 * Int(size.width), space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
            
            guard let cgImage = self.cgImage else { return nil }
            context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
            return pixelData
    }
    
    func preprocess(image: UIImage) -> MLMultiArray? {
        let size = CGSize(width: 100, height: 100)
        
        
        guard let pixels = image.resizeImage()?.pixelData()?.map({ Double($0) }) else {
            return nil
        }
        
        guard let array = try? MLMultiArray(shape: [1, 100, 100, 3], dataType: .float32) else {
            return nil
        }
        
        let r = pixels.enumerated().filter { $0.offset % 4 == 0 }.map { $0.element }
        let g = pixels.enumerated().filter { $0.offset % 4 == 1 }.map { $0.element }
        let b = pixels.enumerated().filter { $0.offset % 4 == 2 }.map { $0.element }
        
        for index in 0..<10000 {
            array[index * 3] =  NSNumber(value: r[index])
            array[index * 3 + 1] = NSNumber(value: g[index])
            array[index * 3 + 2] =  NSNumber(value: b[index])
        }
        
        return array
    }
}
