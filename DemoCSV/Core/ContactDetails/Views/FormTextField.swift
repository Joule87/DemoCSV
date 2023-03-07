//
//  FormTextField.swift
//  DemoCSV
//
//  Created by Julio Collado Perez on 3/6/23.
//

import UIKit

class FormTextField: UITextField {
    
    private var padding = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setInteractionUI(_ editable: Bool) {
        self.isUserInteractionEnabled = editable
        self.borderStyle = editable ? .roundedRect : .none
        self.backgroundColor = editable ? UIColor.white : UIColor.clear
    }
    
    private func setupUI() {
        self.backgroundColor = UIColor.clear
        self.font = UIFont.systemFont(ofSize: 16)
        self.borderStyle = .none
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.clearButtonMode = .whileEditing
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
