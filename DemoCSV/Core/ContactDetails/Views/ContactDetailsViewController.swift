//
//  ContactDetailsViewController.swift
//  DemoCSV
//
//  Created by Julio Collado Perez on 3/3/23.
//

import UIKit
import Combine

class ContactDetailsViewController: UIViewController {
    
    // MARK: - Properties
    static let identifier = "ContactDetailsViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var mainContainerView: UIView! {
        didSet {
            mainContainerView.layer.borderWidth = 0.1
            mainContainerView.layer.borderColor = UIColor.black.cgColor
            mainContainerView.layer.cornerRadius = 10
            mainContainerView.layer.shadowColor = UIColor.black.cgColor
            mainContainerView.layer.shadowOpacity = 0.5
            mainContainerView.layer.shadowOffset = CGSize(width: 5, height: 5)
            mainContainerView.layer.shadowRadius = 4
            mainContainerView.layer.shadowPath = UIBezierPath(rect: mainContainerView.bounds).cgPath
           
        }
    }
    
    @IBOutlet weak var nameContainerView: ContactDetailView! {
        didSet {
            nameContainerView.set(header: "first name:", value: viewModel.firstName)
        }
    }
    
    @IBOutlet weak var lastNameContainerView: ContactDetailView! {
        didSet {
            lastNameContainerView.set(header: "last name:", value: viewModel.lastName)
        }
    }
    
    @IBOutlet weak var stateContainerView: ContactDetailView!  {
        didSet {
            stateContainerView.set(header: "state:", value: viewModel.state)
        }
    }
    @IBOutlet weak var cityContainerView: ContactDetailView!  {
        didSet {
            cityContainerView.set(header: "city:", value: viewModel.city)
        }
    }
    
    @IBOutlet weak var companyContainerView: ContactDetailView! {
        didSet {
            companyContainerView.set(header: "company:", value: viewModel.company)
        }
    }
    
    @IBOutlet weak var zipContainer: ContactDetailView! {
        didSet {
            zipContainer.set(header: "zip:", value: viewModel.zip)
        }
    }
    
    @IBOutlet weak var countyContainer: ContactDetailView! {
        didSet {
            countyContainer.set(header: "county:", value: viewModel.county)
        }
    }
    
    @IBOutlet weak var addressContainerView: ContactDetailView! {
        didSet {
            addressContainerView.set(header: "address:", value: viewModel.address)
        }
    }
    
    @IBOutlet weak var emailContainerView: ContactDetailView! {
        didSet {
            emailContainerView.set(header: "email:", value: viewModel.email)
        }
    }
    
    @IBOutlet weak var primaryPhoneNumberContainerView: ContactDetailView! {
        didSet {
            primaryPhoneNumberContainerView.set(header: "primary phone:", value: viewModel.primaryPhoneNumber)
        }
    }
    
    @IBOutlet weak var secondaryPhoneNumberContainerView: ContactDetailView! {
        didSet {
            secondaryPhoneNumberContainerView.set(header: "secondary phone:", value: viewModel.secondaryPhoneNumber)
        }
    }
    
    var viewModel: ContactDetailsViewModel!
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var editButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "",
                               style: .plain,
                               target: self,
                               action: #selector(didTapRightButton))
    }()
    
    
    // MARK: - Actions
    
    @objc func didTapRightButton() {
        viewModel.screenState.next()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = editButton
        title = "Details"
        setSubscriptions()
    }
    
    private func setSubscriptions() {
        viewModel.$screenState
            .sink { [weak self] value in
                self?.editButton.title = (value == .none || value == .save) ? "Edit" : "Save"
                self?.updateViews(isEditing: value == .editing)
            }
            .store(in: &subscriptions)
        
        setSubscription()
        
    }
    
    private func setSubscription() {
        nameContainerView.text
            .sink { [weak self] value in
                self?.viewModel.firstName = value
            }
            .store(in: &subscriptions)
        
        lastNameContainerView.text
            .sink { [weak self] value in
                self?.viewModel.lastName = value
            }
            .store(in: &subscriptions)
        
        stateContainerView.text
            .sink { [weak self] value in
                self?.viewModel.state = value
            }
            .store(in: &subscriptions)
        
        cityContainerView.text
            .sink { [weak self] value in
                self?.viewModel.city = value
            }
            .store(in: &subscriptions)
        
        zipContainer.text
            .sink { [weak self] value in
                self?.viewModel.zip = value
            }
            .store(in: &subscriptions)
        
        countyContainer.text
            .sink { [weak self] value in
                self?.viewModel.county = value
            }
            .store(in: &subscriptions)
        
        companyContainerView.text
            .sink { [weak self] value in
                self?.viewModel.company = value
            }
            .store(in: &subscriptions)
        
        addressContainerView.text
            .sink { [weak self] value in
                self?.viewModel.address = value
            }
            .store(in: &subscriptions)
        
        emailContainerView.text
            .sink { [weak self] value in
                self?.viewModel.email = value
            }
            .store(in: &subscriptions)
        
        primaryPhoneNumberContainerView.text
            .sink { [weak self] value in
                self?.viewModel.primaryPhoneNumber = value
            }
            .store(in: &subscriptions)
        
        secondaryPhoneNumberContainerView.text
            .sink { [weak self] value in
                self?.viewModel.secondaryPhoneNumber = value
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Helper Functions
    private func updateViews(isEditing: Bool) {
        update(nameContainerView, isEditing: isEditing)
        update(lastNameContainerView, isEditing: isEditing)
        update(companyContainerView, isEditing: isEditing)
        update(stateContainerView, isEditing: isEditing)
        update(cityContainerView, isEditing: isEditing)
        update(zipContainer, isEditing: isEditing)
        update(countyContainer, isEditing: isEditing)
        update(addressContainerView, isEditing: isEditing)
        update(emailContainerView, isEditing: isEditing)
        update(primaryPhoneNumberContainerView, isEditing: isEditing)
        update(secondaryPhoneNumberContainerView, isEditing: isEditing)
    }
    
    private func update(_ containerView: ContactDetailView, isEditing: Bool) {
        containerView.contentTextField.setInteractionUI(isEditing)
    }
    
}
