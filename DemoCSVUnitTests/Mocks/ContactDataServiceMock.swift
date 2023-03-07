//
//  ContactDataServiceMock.swift
//  DemoCSVUnitTests
//
//  Created by Julio Collado Perez on 3/7/23.
//

import Foundation
import Combine
@testable import DemoCSV

struct ContactDataServiceMock: ContactDataProtocol {
    let expectedContacts: [Contact]
    
    init(expectedContacts: [Contact]) {
        self.expectedContacts = expectedContacts
    }
    
    func load() -> AnyPublisher<[Contact], Error> {
        Just(expectedContacts)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
