//
//  ListItem.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/19.
//

import UIKit
import SnapKit
import Then
import Kingfisher


class ListItem: UICollectionViewCell {
    static let id: String = "ListItem"
    
    private let ivImage = UIImageView()
    
    private let svStacks = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 3
    }
    
    private let lblBrand = UILabel().then {
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 12)
    }
    
    private let lblName = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 2
    }
    
    private let svPrice = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.alignment = .leading
    }
    
    private let lblDiscountRate = UILabel().then {
        $0.textColor = .orange
        $0.font = .boldSystemFont(ofSize: 16)
    }
    
    private let lblPrice = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
    }
    
    private let svReview = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.alignment = .center
    }
    
    private let ivStar = UIImageView().then {
        let image = UIImage(systemName: "star.fill")
        $0.image = image
        $0.tintColor = .yellow
    }
    
    private let lblReviewAvg = UILabel().then {
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 10)
    }
    
    private let vDevider = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let lblReviewCount = UILabel().then {
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 10)
    }
    
    private let lblTag = PaddingLabel(withInsets: 2.5, 2.5, 5, 5).then {
        $0.backgroundColor = .systemGray6
        $0.text = "무료배송"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 10)
        $0.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        
        let priceSubviews = [
            lblDiscountRate, lblPrice
        ]
        
        svPrice.addArrangedSubviews(priceSubviews)
        
        let reviewSubviews = [
            ivStar, lblReviewAvg, vDevider, lblReviewCount
        ]
        
        svReview.addArrangedSubviews(reviewSubviews)
        
        let subviews = [
            lblBrand, lblName, svPrice, svReview, lblTag
        ]
        
        svStacks.addArrangedSubviews(subviews)
        
        let views = [
            ivImage,  svStacks
        ]
        
        self.contentView.addSubviews(views)
    }
    
    private func setLayout() {
        ivImage.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.contentView)
            make.height.equalTo(ivImage.snp.width)
        }
        
        svStacks.snp.makeConstraints { make in
            make.top.equalTo(ivImage.snp.bottom).offset(5)
            make.left.right.equalTo(self.contentView)
        }
        
        ivStar.snp.makeConstraints { make in
            make.width.height.equalTo(15)
        }
        
        vDevider.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(5)
        }
    }
    
    func setValue(_ value: ProductModel) {
        if let url = URL(string: value.imgUrl) {
            ivImage.kf.setImage(with: url)
        }
        
        lblBrand.text = value.brand
        
        lblName.text = value.name
        
        lblDiscountRate.isHidden = !(value.discountRate() > 0)
        lblDiscountRate.text = "\(value.discountRate())%"
        
        lblPrice.text = value.price.comma
        
        svReview.isHidden = !(value.reviewCount > 0)
        
        lblReviewAvg.text = "\(value.reviewAvg)/5"
        
        lblReviewCount.text = "리뷰 \(value.reviewCount)"
        
        lblTag.isHidden = !value.tags.contains("FREE_DELIVERY")
    }
}
