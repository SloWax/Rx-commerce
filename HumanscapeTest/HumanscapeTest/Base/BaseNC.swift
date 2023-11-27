//
//  BaseNC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/07/29.
//  Copyright © 2022 SloWax. All rights reserved.


import UIKit


class BaseNC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarAppearance()
    }
    
    private func setupNavigationBarAppearance() {
        navigationBar.tintColor = .black
    }
}
