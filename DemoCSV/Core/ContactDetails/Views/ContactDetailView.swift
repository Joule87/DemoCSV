//
//  ContactDetailView.swift
//  DemoCSV
//
//  Created by Julio Collado Perez on 3/3/23.
//

import UIKit
import Combine

class ContactDetailView: UIView {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var contentTextField: FormTextField!
    
    private var subscriptions = Set<AnyCancellable>()
    
    let text = CurrentValueSubject<String, Never>("")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
        setSubscribers()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        fromNib()
        setSubscribers()
    }
    
    private func setSubscribers() {
        contentTextField.createBinding(with: text, storeIn: &subscriptions)
    }
    
    func set(header title: String, value: String) {
        self.headerLabel.text = title
        self.text.value = value
    }
    
}
