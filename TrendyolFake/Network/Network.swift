//
//  Network.swift
//  TrendyolFake
//
//  Created by Ömer Firat on 19.12.2020.
//

import Foundation

class Network {
    static func getHomePageData(successHandler: @escaping([Brand])->()){
        var brandList:[Brand] = [Brand]()
        brandList.append(Brand.init(id: 1, brandName: "Koton", imageName: "koton"))
        brandList.append(Brand.init(id: 2, brandName: "Pierre Cardin", imageName: "pierrecardin"))
        brandList.append(Brand.init(id: 3, brandName: "Trendyol Milla", imageName: "trendyolmilla"))
        brandList.append(Brand.init(id: 4, brandName: "Ltb", imageName: "ltb"))
        brandList.append(Brand.init(id: 5, brandName: "Derimod", imageName: "derimod"))
        brandList.append(Brand.init(id: 6, brandName: "Lufian", imageName: "lufian"))
        successHandler(brandList)

        
    }
    
    static func getCategoryList(successHandler: @escaping([Subcategory])->()){
            var subcategoryList:[Subcategory] = [Subcategory]()
        subcategoryList.append(Subcategory.init(id: 0, categoryName: "All"))
        subcategoryList.append(Subcategory.init(id: 1, categoryName: "T-Shirt"))
        subcategoryList.append(Subcategory.init(id: 2, categoryName: "Ceket"))
        subcategoryList.append(Subcategory.init(id: 3, categoryName: "Pantolon"))
        subcategoryList.append(Subcategory.init(id: 4, categoryName: "Kot"))
        subcategoryList.append(Subcategory.init(id: 5, categoryName: "Sweatshirt"))
        subcategoryList.append(Subcategory.init(id: 6, categoryName: "Terlik"))
        subcategoryList.append(Subcategory.init(id: 7, categoryName: "Gömlek"))

        successHandler(subcategoryList)
        }

    static func getProductList(brandId:Int,successHandler: @escaping([Product])->() ){
        var productList:[Product] = [Product]()
        productList.append(Product.init(id: 1, brandId: 1, subcategoryId: 2, productName: "Koton Siyah Erkek Ceket", imageName: "ceket1", price: 23.99, brandName: "Koton"))
        productList.append(Product.init(id: 2, brandId: 1, subcategoryId: 2, productName: "Koton Ekoseli Gri Kadın Ceket", imageName: "ceket2", price: 119.99, brandName: "Koton"))
        productList.append(Product.init(id: 3, brandId: 3, subcategoryId: 2, productName: "TrendyolMilla Siyah Kadın Ceket", imageName: "ceket3", price: 99.99, brandName: "TrendyolMilla"))
        productList.append(Product.init(id: 4, brandId: 1, subcategoryId: 2, productName: "Koton Kırmızı Kadın Ceket", imageName: "ceket4", price: 56.99, brandName: "Koton"))
        productList.append(Product.init(id: 5, brandId: 0, subcategoryId: 5, productName: "Nike Basic Tshirt", imageName: "Tshirt", price: 32.99, brandName: "Nike"))
        productList.append(Product.init(id: 6, brandId: 1, subcategoryId: 4, productName: "Koton Siyah Kadın Kot", imageName: "Kot", price: 29.99, brandName: "Koton"))


        productList = productList.filter{
            $0.brandId == brandId
        }
        
        successHandler(productList)
    }
    
}

