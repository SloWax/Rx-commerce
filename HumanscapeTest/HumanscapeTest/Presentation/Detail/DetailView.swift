//
//  DetailView.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/19.
//

import UIKit
import SnapKit
import Then


class DetailView: BaseView {
    
    private let lblTitle = UILabel().then {
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        self.addSubview(lblTitle)
    }
    
    private func setLayout() {
        lblTitle.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.safeAreaLayoutGuide).inset(15)
        }
    }
    
    func setValue(_ value: ProductModel) {
        lblTitle.text = value.name
    }
}
