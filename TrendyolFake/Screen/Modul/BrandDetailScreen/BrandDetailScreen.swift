//
//  BrandDetailScreen.swift
//  TrendyolFake
//
//  Created by Ömer Firat on 19.12.2020.
//

import UIKit

class BrandDetailScreen: BaseScreen {
    
    @IBOutlet weak var clvSubcategory: UICollectionView!
    @IBOutlet weak var clvProduct: UICollectionView!
    var subcategoryList:[Subcategory]?
    
    var productList:[Product]?
    var filterProductList:[Product]?

    var brand:Brand?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Network.getCategoryList{[weak self](subcategoryList) in
            self?.subcategoryList = subcategoryList
            self?.clvSubcategory.reloadData()
        
        }  // Do any additional setup after loading the view.
        
        Network.getProductList(brandId: brand?.iD ?? 0) { [weak self] (productList) in
            self?.productList = productList
            self?.filterProductList = productList
            self?.clvProduct.reloadData()
            
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension BrandDetailScreen: AddToBasketDelegate {
    func addToBasket(product: Product) {
        ActionSheet.init(view: self, product: product)
    }
}


extension BrandDetailScreen: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(clvProduct == collectionView){
            return filterProductList?.count ?? 0
        }else if(clvSubcategory == collectionView){
            return subcategoryList?.count ?? 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if(clvSubcategory == collectionView){
                if(self.subcategoryList![indexPath.row].iD == 0){
                    self.filterProductList = self.productList
                }else {
                    self.filterProductList = productList?.filter{
                        $0.subcategoryId == self.subcategoryList![indexPath.row].iD
                    }
                }
                self.clvProduct.reloadData()
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(clvProduct == collectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentify.ProductCell, for: indexPath as IndexPath) as! ProductCell
            cell.addToBasketDelegate = self
            cell.imgProduct.image = UIImage.init(named: filterProductList?[indexPath.row].imageName ?? "")
            cell.lblProductName.text = self.filterProductList?[indexPath.row].productName
            cell.setData(product: self.filterProductList![indexPath.row])
            cell.lblProductPrice.text = "\((self.filterProductList?[indexPath.row].price)!)"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentify.SubcategoryCell, for: indexPath as IndexPath) as! SubcategoryCell
            cell.lblSubcategory.text = (subcategoryList?[indexPath.row].categoryName) ?? ""
            return cell
        }
    }
    
    
}
