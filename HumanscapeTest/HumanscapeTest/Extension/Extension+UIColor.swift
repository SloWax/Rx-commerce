//
//  Extension+UIColor.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/19.
//

import UIKit

extension UIColor {
    func toImage(width: CGFloat = 1.0, height: CGFloat = 1.0) -> UIImage {
        let size = CGSize(width: width, height: height)
        
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
