//
//  DetailVM.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/19.
//


import Foundation
import RxSwift
import RxCocoa


class DetailVM: BaseVM {
    struct Input {
        
    }
    
    struct Output {
        let productData = PublishRelay<ProductModel>()
    }
    
    let input: Input
    let output: Output
    
    init(input: Input = Input(), output: Output = Output(),
         _ hash: String) {
        
        self.input = input
        self.output = output
        
        super.init()
        
        getProduct(hash)
    }
    
    // GET 상품 정보 가져오기
    private func getProduct(_ hash: String) {
        CommerceService.shared
            .request(.product(hash: hash), CommerceDto.Response.Product.self)
            .subscribe { [weak self] data in
                guard let self = self else { return }
                
                let product = ProductModel(
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
                
                self.output.productData.accept(product)
            } onFailure: { [weak self] error in
                guard let self = self else { return }
                
                self.error.accept(error)
            }.disposed(by: bag)
    }
}
