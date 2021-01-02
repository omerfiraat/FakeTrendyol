//
//  PaymentScreen.swift
//  TrendyolFake
//
//  Created by Ömer Firat on 2.01.2021.
//

import UIKit

class PaymentScreen: UIViewController {

    var selectionPayment:PaymentType?
    @IBOutlet weak var btnCash: UIButton!
    @IBOutlet weak var btnCard: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClickPaymentType(_ sender: Any) {
        if(sender as! NSObject == btnCard){
            btnCard.setImage(UIImage.init(systemName: "circle.fill" ), for: .normal)
            selectionPayment = .card
        } else {
            btnCard.setImage(UIImage.init(systemName: "circle" ), for: .normal)
        }
        if(sender as! NSObject == btnCash ) {
            btnCash.setImage(UIImage.init(systemName: "circle.fill" ), for: .normal)
            selectionPayment = .cash
        } else {
            btnCash.setImage(UIImage.init(systemName: "circle" ), for: .normal)
        }
}
}
