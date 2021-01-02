//
//  UIViewExtensions.swift
//  TrendyolFake
//
//  Created by Ömer Firat on 19.12.2020.
//

import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable // Attributese özellik eklemeye yarıyor
extension UIView {
    // Attributese eklenen özelliği orada göstermeye yarıyor.
    @IBInspectable  var cornerRadius: CGFloat{
        get { return self.layer.cornerRadius}
        set {self.layer.cornerRadius = newValue}
    }
    
    
    @IBInspectable
    var borderWidth: CGFloat {
      get {
        return layer.borderWidth
      }
      set {
        layer.borderWidth = newValue
      }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
      get {
        if let color = layer.borderColor {
          return UIColor(cgColor: color)
        }
        return nil
      }
      set {
        if let color = newValue {
          layer.borderColor = color.cgColor
        } else {
          layer.borderColor = nil
        }
      }
    }
    
}
