//
//  TitleView.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/23.
//


import UIKit
import SnapKit
import Then


class TitleView: UIView {
    
    private let lblTitle = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    private let vDivider = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    init(title: String) {
        super.init(frame: .zero)
        
        lblTitle.text = title
        
        let views = [lblTitle, vDivider]
        
        self.addSubviews(views)
        
        lblTitle.snp.makeConstraints { make in
            make.top.left.equalTo(self).inset(15)
            make.bottom.equalTo(self).inset(5)
        }
        
        vDivider.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
