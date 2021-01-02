//
//  ActionSheet.swift
//  TrendyolFake
//
//  Created by Bekir on 27.12.2020.
//

import UIKit

protocol AddBasketDelegate: class{
    func addProduct()
}

class ActionSheet: UIViewController {
    
    @IBOutlet weak var cnsMenuBottom: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var btnLarge: UIButton!
    @IBOutlet weak var btnMedium: UIButton!
    @IBOutlet weak var btnSmall: UIButton!
    @IBOutlet weak var viewSmallSize: UIView!
    @IBOutlet weak var viewMediumSize: UIView!
    @IBOutlet weak var viewLargeSize: UIView!
    @IBOutlet weak var stpProduct: UIStepper!
    var delegate:AddBasketDelegate?

    var product:Product?
    var basketProduct: BasketProduct = BasketProduct()
    var topLimit = -40
    var bottomLimit = -500
    var selectionSize: SizeType?
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewData(product: product!)
        self.lblPrice.text = "\((product?.price)!)"
        self.lblBrandName.text = product?.brandName
        self.imgProduct.image = UIImage.init(named: product?.imageName ?? "")
        self.lblTitle.text = product?.productName
        
        
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func onClickClose(_ sender: Any) {
        closeScreen()
    }
    
    @IBAction func onClickMenuOutside(_ sender: Any) {
        closeScreen()
    }
    @IBAction func onClickStepper(_ sender: UIStepper) {
        if let stepper = sender as? UIStepper {
            count = Int(stepper.value)
            basketProduct.count = count
            self.lblCount.text = "\(count)"
        }
        
    }
    
    @IBAction func menuActionSheetPanGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            // nothing
            
            // vwActionSheet.backgroundColor = UIColor.red
            /**
             action sheet view rengini degitirebilirsiniz
             */
            
        } else if sender.state == UIGestureRecognizer.State.changed {
            let translationY = sender.translation(in: sender.view).y
            if translationY > 0 {
                
                //  self.vwActionSheet.alpha = 1 - translationY/400
                self.cnsMenuBottom.constant = CGFloat(topLimit) - translationY
            } else {
                self.cnsMenuBottom.constant = CGFloat(topLimit) - (translationY / 8)
            }
        }else {
            // vwActionSheet.backgroundColor = UIColor.white
            
            if cnsMenuBottom.constant < -100 {
                closeScreen()
            } else {
                setMenuInitialState()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setMenuInitialState()
    }
    
    func setMenuInitialState() {
        self.cnsMenuBottom.constant = CGFloat(topLimit)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            
            //
        })
    }
    
    
    func closeScreen() {
        //delegate?.notifyCityScreenClose()
        self.cnsMenuBottom.constant = CGFloat(bottomLimit)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor.clear
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    @IBAction func onClickAddBasket(_ sender: Any) {
        BasketData.sharedInstance.addProductBasket(basketProduct: basketProduct)
        setViewData(product: product!)
        count = 0
        basketProduct.count = count
        self.lblCount.text = "\(count)"
        stpProduct.value = 0
        delegate?.addProduct()
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("AddBasketProduct"),object: nil)
        
    }
    
    func setViewData(product:Product){
        basketProduct.product = product
        self.lblTitle.text = product.productName
        let image = product.imageName ?? "Product"
        self.imgProduct.image = UIImage(named: image)
        var product = BasketData.sharedInstance.getBasketProduct(basketProduct: basketProduct)
        self.lblCount.text = "\(count)"
    }
    
    @IBAction func onCliclSelectSize(_ sender: Any) {
        if(sender as? NSObject == btnSmall){
            viewSmallSize.borderColor = .red
            selectionSize = .small
        }else{
            viewSmallSize.borderColor = .opaqueSeparator
        }
        if(sender as? NSObject == btnMedium){
            viewMediumSize.borderColor = .red
            selectionSize = .small
        }else{
            viewMediumSize.borderColor = .opaqueSeparator
        }
        if(sender as? NSObject == btnLarge){
            viewLargeSize.borderColor = .red
            selectionSize = .small
        }else{
            viewLargeSize.borderColor = .opaqueSeparator
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



extension ActionSheet {
    public convenience init(view: UIViewController, product:Product) {
        self.init(nibName: "ActionSheet", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.product = product
        view.present(self, animated: false, completion: nil)
    }
    
}
