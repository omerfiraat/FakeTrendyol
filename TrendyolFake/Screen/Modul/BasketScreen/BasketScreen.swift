//
//  BasketScreen.swift
//  TrendyolFake
//
//  Created by Ömer Firat on 2.01.2021.
//

import UIKit

class BasketScreen: UIViewController {
    
    @IBOutlet weak var tbvBasket: UITableView!
    var listBasketProduct: [BasketProduct] = [BasketProduct]()
    @IBOutlet weak var lblSummaryPrice: UILabel!
    
    var sum:Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        listBasketProduct = BasketData.sharedInstance.getBasketProductList()
        
        tbvBasket.reloadData()
        basketTotalPrice()
        
        // Do any additional setup after loading the view.
    }
    
    func basketTotalPrice() {
        sum = 0.0
        for basketProduct in listBasketProduct {
            sum = sum + (Double(basketProduct.count) * (basketProduct.product?.price)!)
        }
        lblSummaryPrice.text = "\(sum)"
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

extension BasketScreen: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBasketProduct.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketProductCell", for: indexPath) as! BasketProductCell
        let image = listBasketProduct[indexPath.row].product?.imageName ?? "Product"
        let totalPrice = (listBasketProduct[indexPath.row].product?.price)! * Double(listBasketProduct[indexPath.row].count)
        
        cell.imgProduct.image = UIImage(named: image)
        cell.lblProductCount.text = "\(listBasketProduct[indexPath.row].count)"
        cell.lblProductName.text = listBasketProduct[indexPath.row].product?.productName
        cell.lblProductPrice.text = "\((listBasketProduct[indexPath.row].product?.price)!)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            BasketData.sharedInstance.removeProductBasket(basketProduct:
            self.listBasketProduct[indexPath.row])
            self.listBasketProduct.remove(at: indexPath.row)
            self.tbvBasket.deleteRows(at: [indexPath], with: .fade)
            basketTotalPrice()
            
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("DeleteBasketProduct"), object: nil)
        }
    }
    
    
}
