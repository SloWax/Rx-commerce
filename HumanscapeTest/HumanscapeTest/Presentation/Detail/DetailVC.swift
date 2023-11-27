//
//  DetailVC.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/19.
//


import UIKit
import RxSwift
import RxCocoa


class DetailVC: BaseVC {
    private let detailView = DetailView()
    private let vm: DetailVM
    
    init(_ hash: String) {
        self.vm = DetailVM(hash)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func initialize() {
        view = detailView
    }
    
    private func bind() {
        vm.output
            .productData
            .bind { [weak self] data in
                guard let self = self else { return }
                
                self.detailView.setValue(data)
            }.disposed(by: vm.bag)
    }
}
