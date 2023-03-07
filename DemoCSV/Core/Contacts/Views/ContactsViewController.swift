//
//  ContactsViewController.swift
//  DemoCSV
//
//  Created by Julio Collado Perez on 3/3/23.
//

import UIKit
import Combine

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    var viewModel = ContactsViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadContactData()
        
        title = "Contacts"
        setupContactTableView()
        setSubscription()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = viewModel.indexPendingToReload {
            contactsTableView.reloadRows(at: [indexPath], with: .automatic)
            viewModel.indexPendingToReload = nil
        }
    }
    
    private func setSubscription() {
        contactsTableView.createBinding(with: viewModel.$contacts, completion: { [weak self] _ in
            guard let self = self else { return }
            self.contactsTableView.reloadData()
        }, storeIn: &subscriptions)
    }
    
    private func setupContactTableView() {
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.register(UINib(nibName: ContactUITaTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ContactUITaTableViewCell.identifier)
        contactsTableView.separatorStyle = .none
    }
    
    func navigateToViewController(withId identifier: String, contactData: Contact, indexPath: IndexPath) {
        guard let destinationVC = storyboard?.instantiateViewController(withIdentifier: identifier) as? ContactDetailsViewController else {
            return
        }
        
        let viewModel = ContactDetailsViewModel(contact: contactData, indexPath: indexPath)
        destinationVC.viewModel = viewModel
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactUITaTableViewCell.identifier) as? ContactUITaTableViewCell else {
            return UITableViewCell()
        }
        let contact = viewModel.contacts[indexPath.row]
        
        let fullName = "\(contact.firstName) \(contact.lastName)"
        let phone = "\(contact.phone), \(contact.phone1)"
        
        cell.set(name: fullName, email: contact.email, phoneNumber: phone)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = viewModel.contacts[indexPath.row]
        navigateToViewController(withId: ContactDetailsViewController.identifier, contactData: contact, indexPath: indexPath)
    }
    
}
