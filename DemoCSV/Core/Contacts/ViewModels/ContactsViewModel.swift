//
//  ContactsViewModel.swift
//  DemoCSV
//
//  Created by Julio Collado Perez on 3/3/23.
//

import Foundation
import Combine

class ContactsViewModel {
    
    // MARK: - Publishers
    @Published var contacts: [Contact] = []
    var indexPendingToReload: IndexPath?
    
    // MARK: - Services
    var contactDataService: ContactDataProtocol = ContactDataService()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        NotificationCenter.default
            .publisher(for: .didChangeContactData)
            .compactMap { $0.userInfo?[KeyContastants.indexPath] as? IndexPath }
            .sink { [weak self] value in
                self?.indexPendingToReload = value
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Subscriptions
    func loadContactData() {
        contactDataService.load()
            .sink(receiveCompletion: ContactDataService.handleCompletion(completion:)) { contacts in
                self.contacts = contacts.sorted{  $0.firstName < $1.firstName }
        }.store(in: &subscriptions)
    }
}
