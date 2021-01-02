//
//  BaseData.swift
//  TrendyolFake
//
//  Created by Bekir on 19.12.2020.
//

import Foundation

enum SizeType{
    case small
    case medium
    case large
}
enum PaymentType{
    case card
    case cash
}

class BasketData{
    static var sharedInstance = BasketData()
    var isAddedBefore: Bool?
    var adress:String?
    var paymentType:PaymentType?
    
    private init(){
        
    }
    var basketProductList: [BasketProduct] = [BasketProduct]()
    func addProductBasket(basketProduct: BasketProduct){
        var isAddedBefore = false
        for (index, item) in basketProductList.enumerated(){
            
            if(item.product?.iD == basketProduct.product?.iD){
                basketProductList[index].count = basketProductList[index].count + basketProduct.count
                isAddedBefore = true
            }
        }
        if(isAddedBefore == false){
            basketProductList.append(basketProduct)
        }
        
    }
    func getBasketProductList() -> [BasketProduct]{
        return basketProductList
    }
    
    func removeProductBasket(basketProduct:BasketProduct){
        var indexItem = 0
        for (index, item) in basketProductList.enumerated(){
            
            if(item.product?.iD == basketProduct.product?.iD){
                var indexItem = index
            }
            
        }
        basketProductList.remove(at: indexItem)
    }
    
    func getBasketProduct(basketProduct:BasketProduct) -> BasketProduct?{
        var basketProductDummy: BasketProduct?
        for (index,item) in basketProductList.enumerated(){
            
            if(item.product?.iD == basketProduct.product?.iD){
                basketProductDummy = basketProductList[index]
                
            }
        }
        return basketProductDummy
    }
    func basketTotalPrice() -> Double {
        var sum = 0.0
        for basketProduct in self.basketProductList{
            sum = sum + (Double(basketProduct.count) * (basketProduct.product?.price)!)
        }
        return sum
    }
    func decreaseProductBasket(basketProduct: BasketProduct){
        for (index,item) in basketProductList.enumerated(){
            
            if(item.product?.iD == basketProduct.product?.iD){
                basketProductList[index].count = basketProductList[index].count - basketProduct.count
                isAddedBefore = true
            }
        }
    }
}


class BaseData {
    
    static var sharedInstance = BaseData()
    private init(){
        
    }
    
    
    
    var favoriteList:[Product] = [Product]()
    
    func addFavoriteProduct(product:Product) {
        if(!isProductFavorite(productId: product.iD ?? 0)){
            favoriteList.append(product)
            
        }
    }
    
    func removeFavoriteProduct(product:Product){
        var removeIndex = -1
        for (index, item) in favoriteList.enumerated(){
            if(item.iD == product.iD){
                removeIndex = index
            }
        }
        
        if(removeIndex != -1){
            favoriteList.remove(at: removeIndex)
        }
    }
    
    
    func isProductFavorite(productId:Int) -> Bool{
        for product in favoriteList{
            if(product.iD == productId){
                return true
            }
        }
        return false
    }
    func getFavoriteList() -> [Product]{
        return favoriteList
    }
    
}
