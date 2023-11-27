//
//  ListVM.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/19.
//


import Foundation
import RxSwift
import RxCocoa


class ListVM: BaseVM {
    struct Input {
        let requestList = PublishRelay<Bool>()
    }
    
    struct Output {
        // Void
        let refreshComplete = PublishRelay<Void>()
        
        // Data
        let productList = BehaviorRelay<[ProductModel]>(value: [])
    }
    
    let input: Input
    let output: Output
    var isRequest = false
    
    private var page = 0
    private var isFinal = false
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        super.init()
        
        self.input
            .requestList // list 다음 페이지
            .bind { [weak self] isRefresh in
                guard let self = self else { return }
                
                guard !isFinal, !isRequest else { return }
                
                self.isRequest = true
                self.getProducts(isRefresh)
            }.disposed(by: bag)
        
        getProducts(false)
    }
    
    // GET 상품 리스트 가져오기
    private func getProducts(_ isRefresh: Bool) {
        
        let productsQuery = CommerceDto.Request.Products(
            offset: isRefresh ? 0 : page + 1,
            limit: 20
        )
        
        guard let productsQuery = productsQuery.toDictionary else { return }
        
        CommerceService.shared
            .request(.products(query: productsQuery), CommerceDto.Response.Products.self)
            .subscribe { [weak self] data in
                guard let self = self else { return }
                
                let convertList = data.products
                    .map { data in
                        
                        let newProduct = ProductModel(
                            hash: data.hash,
                            brand: data.brand ?? "",
                            name: data.name,
                            normalPrc: data.normalPrc,
                            sellPrc: data.sellPrc,
                            price: data.sellPrc,
                            imgUrl: data.imgUrl,
                            reviewAvg: data.reviewAvg,
                            reviewCount: data.reviewCount,
                            tags: data.tags
                        )
                        
                        return newProduct
                    }
                
                self.page = data.meta.offset
                self.isFinal = data.meta.isFinal
                
                var list = self.output.productList.value
                isRefresh ? (list = convertList) : (list += convertList)
                
                self.output.productList.accept(list)
                self.output.refreshComplete.accept(Void())
                
                self.isRequest = false
            } onFailure: { [weak self] error in
                guard let self = self else { return }
                
                self.error.accept(error)
            }.disposed(by: bag)
    }
}
