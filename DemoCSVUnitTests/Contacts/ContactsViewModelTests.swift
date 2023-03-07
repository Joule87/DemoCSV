//
//  ContactsViewModelTests.swift
//  DemoCSVUnitTests
//
//  Created by Julio Collado Perez on 3/7/23.
//

import XCTest
import Combine
@testable import DemoCSV

class ContactsViewModelTests: XCTestCase {
    
    var viewModel: ContactsViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = ContactsViewModel()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewModel = nil
        subscriptions.removeAll()
    }
    
    func testContactsPublisher() throws {
        let contact = ContactMocker.contact01
        let expectedContacts = [contact]
        let expectation = self.expectation(description: "✅ Contacts publisher updates")
        var receivedContacts: [Contact] = []
        
        viewModel.$contacts
            .dropFirst()
            .sink { contacts in
                receivedContacts = contacts
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        viewModel.contacts = expectedContacts
        
        waitForExpectations(timeout: 1)
        XCTAssertEqual(receivedContacts, expectedContacts)
    }
    
    func testContactDataServiceLoad() throws {
        let expectedContacts = [ContactMocker.contact01]
        let contactDataServiceMock = ContactDataServiceMock(expectedContacts: expectedContacts)
        viewModel.contactDataService = contactDataServiceMock
        let expectation = self.expectation(description: "✅ Contact data service loads")
        var receivedContacts: [Contact] = []

        viewModel.$contacts
            .dropFirst()
            .sink { contacts in
                receivedContacts = contacts
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        viewModel.loadContactData()

        waitForExpectations(timeout: 1)
        XCTAssertEqual(receivedContacts, expectedContacts)
    }
}
