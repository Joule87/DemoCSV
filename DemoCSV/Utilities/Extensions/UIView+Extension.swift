//
//  UIView+Extension.swift
//  DemoCSV
//
//  Created by Julio Collado Perez on 3/5/23.
//

import UIKit

extension UIView {
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        contentView.frame = bounds
        self.addSubview(contentView)
        return contentView
    }
}
