//
//  ListView.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/19.
//


import UIKit
import SnapKit
import Then


class ListView: BaseView {
    
    private let vTitle = TitleView(title: "쇼핑몰")
    
    lazy var cvList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.delegate = self
            $0.register(ListItem.self, forCellWithReuseIdentifier: ListItem.id)
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.refreshControl = UIRefreshControl()
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        let views = [vTitle, cvList]
        
        self.addSubviews(views)
    }
    
    private func setLayout() {
        vTitle.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        cvList.snp.makeConstraints { make in
            make.top.equalTo(vTitle.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
    }
}

extension ListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let allSpacing: CGFloat = 60
        let width = floor((collectionView.frame.width - allSpacing) / 2)
        let height = width * 1.65
        
        return CGSize(width: width, height: height)
    }
}
