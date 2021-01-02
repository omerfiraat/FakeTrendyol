//
//  Product.swift
//  TrendyolFake
//
//  Created by Ömer Firat on 20.12.2020.
//

import Foundation

class  Product {
    var iD:Int?
    var brandId: Int?
    var subcategoryId:Int?
    var imageName:String?
    var productName:String?
    var price:Double?
    var brandName:String?
    
    
    init(id:Int, brandId:Int, subcategoryId:Int, productName:String, imageName:String, price:Double, brandName:String) {
        self.iD = id
        self.brandId = brandId
        self.imageName = imageName
        self.productName = productName
        self.subcategoryId = subcategoryId
        self.price = price
        self.brandName = brandName
    }
}

