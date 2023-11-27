//
//  ListVC.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/19.
//


import UIKit
import RxSwift
import RxCocoa


class ListVC: BaseMainVC {
    private let listView = ListView()
    private let vm = ListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func initialize() {
        view = listView
    }
    
    private func bind() {
        listView.cvList.refreshControl? // 상품 리스트 새로고침
            .rx
            .controlEvent(.valueChanged)
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.vm.input.requestList.accept(true)
            }.disposed(by: vm.bag)
        
        listView.cvList // 상품 리스트 페이징
            .rx
            .didScroll
            .bind { [weak self] _ in
                guard let self = self else { return }
                
                let tv = self.listView.cvList
                let offSetY = tv.contentOffset.y
                let contentHeight = tv.contentSize.height
                
                guard offSetY + 100 >= (contentHeight - tv.frame.size.height) else { return }
                
                self.vm.input.requestList.accept(false)
            }.disposed(by: vm.bag)
        
        listView.cvList // 상세보기 화면 push
            .rx
            .modelSelected(ProductModel.self)
            .bind{ [weak self] item in
                guard let self = self else { return }
                
                let vc = DetailVC(item.hash)
                self.pushVC(vc, title: "상품 상세보기")
            }.disposed(by: vm.bag)
        
        vm.output
            .refreshComplete // 새로고침 완료
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.listView.cvList.refreshControl?.endRefreshing()
            }.disposed(by: vm.bag)
        
        vm.output // 상품 리스트
            .productList
            .bind(to: listView.cvList
                    .rx
                    .items(cellIdentifier: ListItem.id,
                           cellType: ListItem.self)
            ) { row, data, cell in
                
                cell.setValue(data)
            }.disposed(by: vm.bag)
    }
}
