//
//  ContactDetailsViewModel.swift
//  DemoCSV
//
//  Created by Julio Collado Perez on 3/5/23.
//

import UIKit
import Combine

class ContactDetailsViewModel {
    @Published var screenState: ScreenState = .none
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var company: String = ""
    @Published var state: String = ""
    @Published var city: String = ""
    @Published var zip: String = ""
    @Published var county: String = ""
    @Published var address: String = ""
    @Published var email: String = ""
    @Published var primaryPhoneNumber: String = ""
    @Published var secondaryPhoneNumber: String = ""
    
    @Published var hasEditedContact = false
    
    var contact: Contact
    private var indexPath: IndexPath
    
    private var subscriptions = Set<AnyCancellable>()
    
    enum ScreenState {
        case none
        case editing
        case save
        
        mutating func next() {
            switch self {
            case .none:
                self = .editing
            case .editing:
                self = .save
            case .save:
                self = .editing
            }
        }
    }
    
    init(contact: Contact, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.contact = contact
        
        self.firstName = contact.firstName
        self.lastName = contact.lastName
        self.company = contact.companyName
        self.state = contact.state
        self.city = contact.city
        self.zip = contact.zip
        self.county = contact.county
        
        self.address = contact.address
        self.email = contact.email
        self.primaryPhoneNumber = contact.phone
        self.secondaryPhoneNumber = contact.phone1
        
        setSubscriptions()
    }
    
    private func setSubscriptions() {
        $screenState
            .filter { $0 == .save }
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.contact.address = self.address
                self.contact.email = self.email
                self.contact.phone = self.primaryPhoneNumber
                self.contact.phone1 = self.secondaryPhoneNumber
                self.contact.county = self.county
                
                self.contact.zip = self.zip
                self.contact.city = self.city
                self.contact.state = self.state
                self.contact.firstName = self.firstName
                self.contact.lastName = self.lastName
                self.contact.companyName = self.company
                
                let userInfo = [KeyContastants.indexPath: self.indexPath]
                NotificationCenter.default.post(name: .didChangeContactData, object: nil, userInfo: userInfo)
            }
            .store(in: &subscriptions)
    }
    
}
