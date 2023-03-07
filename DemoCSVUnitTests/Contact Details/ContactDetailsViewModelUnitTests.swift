//
//  ContactDetailsViewModelUnitTests.swift
//  DemoCSVUnitTests
//
//  Created by Julio Collado Perez on 3/7/23.
//

import XCTest
@testable import DemoCSV

class ContactDetailsViewModelUnitTests: XCTestCase {

    var viewModel: ContactDetailsViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let contact = ContactMocker.contact02
        let indexPath = IndexPath(row: 0, section: 0)
        viewModel = ContactDetailsViewModel(contact: contact, indexPath: indexPath)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewModel = nil
    }
    
    func testInitialState() throws {
        XCTAssertEqual(viewModel.screenState, .none)
        XCTAssertEqual(viewModel.firstName, ContactMocker.contact02.firstName)
        XCTAssertEqual(viewModel.lastName, ContactMocker.contact02.lastName)
        XCTAssertEqual(viewModel.company, ContactMocker.contact02.companyName)
        XCTAssertEqual(viewModel.state, ContactMocker.contact02.state)
        XCTAssertEqual(viewModel.city, ContactMocker.contact02.city)
        XCTAssertEqual(viewModel.zip, ContactMocker.contact02.zip)
        XCTAssertEqual(viewModel.county, ContactMocker.contact02.county)
        XCTAssertEqual(viewModel.address, ContactMocker.contact02.address)
        XCTAssertEqual(viewModel.email, ContactMocker.contact02.email)
        XCTAssertEqual(viewModel.primaryPhoneNumber, ContactMocker.contact02.phone)
        XCTAssertEqual(viewModel.secondaryPhoneNumber, ContactMocker.contact02.phone1)
        XCTAssertFalse(viewModel.hasEditedContact)
    }
    
    func testScreenStateTransitions() throws {
        XCTAssertEqual(viewModel.screenState, .none)
        viewModel.screenState.next()
        XCTAssertEqual(viewModel.screenState, .editing)
        viewModel.screenState.next()
        XCTAssertEqual(viewModel.screenState, .save)
        viewModel.screenState.next()
        XCTAssertEqual(viewModel.screenState, .editing)
        viewModel.screenState.next()
        XCTAssertEqual(viewModel.screenState, .save)
    }
    
    func testSaveContact() throws {
        viewModel.firstName = ContactMocker.contact01.firstName
        viewModel.lastName = ContactMocker.contact01.lastName
        viewModel.company = ContactMocker.contact01.companyName
        viewModel.state = ContactMocker.contact01.state
        viewModel.city = ContactMocker.contact01.city
        viewModel.zip = ContactMocker.contact01.zip
        viewModel.county = ContactMocker.contact01.county
        viewModel.address = ContactMocker.contact01.address
        viewModel.email = ContactMocker.contact01.email
        viewModel.primaryPhoneNumber = ContactMocker.contact01.phone
        viewModel.secondaryPhoneNumber = ContactMocker.contact01.phone1
        
        
        viewModel.screenState = .save
        XCTAssertEqual(viewModel.contact.firstName, viewModel.firstName)
        XCTAssertEqual(viewModel.contact.lastName, viewModel.lastName)
        XCTAssertEqual(viewModel.contact.companyName, viewModel.company)
        XCTAssertEqual(viewModel.contact.state, viewModel.state)
        XCTAssertEqual(viewModel.contact.city, viewModel.city)
        XCTAssertEqual(viewModel.contact.zip, viewModel.zip)
        XCTAssertEqual(viewModel.contact.county, viewModel.county)
        XCTAssertEqual(viewModel.contact.address, viewModel.address)
        XCTAssertEqual(viewModel.contact.email, viewModel.email)
        XCTAssertEqual(viewModel.contact.phone, viewModel.primaryPhoneNumber)
        XCTAssertEqual(viewModel.contact.phone1, viewModel.secondaryPhoneNumber)
    }
    
}
