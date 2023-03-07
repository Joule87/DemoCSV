//
//  ContactMocker.swift
//  DemoCSVUnitTests
//
//  Created by Julio Collado Perez on 3/7/23.
//

import Foundation
@testable import DemoCSV

struct ContactMocker {
    static let contact01 = Contact(firstName: "Watt", lastName: "Vermont", companyName: "Amazon", address: "540 th street", city: "Kansas City", county: "Bin", state: "Kansas", zip: "23322", phone1: "234 234 3422", phone: "345 345 5535", email: "vermont@gmail.com")
    static let contact02 = Contact(firstName: "John", lastName: "Doe", companyName: "Acme Inc.", address: "123 Main St.", city: "San Francisco", county: "San Francisco County", state: "CA", zip: "94105", phone1: "555-123-2343", phone: "555-123-2311", email: "john.doe@acme.com")
}
