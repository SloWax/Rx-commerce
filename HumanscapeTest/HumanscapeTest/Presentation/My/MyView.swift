//
//  MyView.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/19.
//

import UIKit
import SnapKit
import Then


class MyView: BaseView {
    
    private let vTitle = TitleView(title: "내정보")
    
    private let lblTitle = UILabel().then {
        $0.text = "No content"
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
        let views = [vTitle, lblTitle]
        
        self.addSubviews(views)
    }
    
    private func setLayout() {
        vTitle.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        lblTitle.snp.makeConstraints { make in
            make.center.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
