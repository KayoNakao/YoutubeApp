//
//  UIImage.swift
//  YoutubeApp
//
//  Created by Kayo Nakao on 2021-04-05.
//  Copyright © 2021 Guarana Technologies Inc. All rights reserved.
//

import UIKit

extension UIImage {
    
    func cropToBounds(width: Double, height: Double) -> UIImage {
        
        let cgimage = self.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        let ratio: CGFloat = 9 / 16
        let height = contextSize.height * ratio
        posX = ((contextSize.width - height) / 2)
        posY = (contextSize.height - height) / 2
        cgwidth = height
        cgheight = height
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        let image: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        return image
    }
}
