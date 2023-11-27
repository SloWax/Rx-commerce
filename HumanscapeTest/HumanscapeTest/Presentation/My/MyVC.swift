//
//  MyVC.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/19.
//


import UIKit
import RxSwift
import RxCocoa


class MyVC: BaseMainVC {
    private let myView = MyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func initialize() {
        view = myView
    }
    
    private func bind() {
        
    }
}
