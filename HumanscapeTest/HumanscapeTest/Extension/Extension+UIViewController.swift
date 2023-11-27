//
//  Extension+UIViewController.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/23.
//

import UIKit

extension UIViewController {
    
    // MARK: ViewController 전환
    
    func pushVC(_ vc: UIViewController, animated: Bool = true, title: String? = nil) {
        if self is BaseMainVC {
            vc.hidesBottomBarWhenPushed = true
        }
        
        vc.title = title
        self.navigationController?.pushViewController(vc, animated: animated)
    }
}
