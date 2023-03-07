//
//  Contact.swift
//  DemoCSV
//
//  Created by Julio Collado Perez on 3/3/23.
//

import Foundation

class Contact: Codable {
    let id = UUID().uuidString
    var firstName: String
    var lastName: String
    var companyName: String
    var address: String
    var city: String
    var county: String
    var state: String
    var zip: String
    var phone1: String
    var phone: String
    var email: String
    
    init(firstName: String, lastName: String, companyName: String, address: String, city: String, county: String, state: String, zip: String, phone1: String, phone: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.companyName = companyName
        self.address = address
        self.city = city
        self.county = county
        self.state = state
        self.zip = zip
        self.phone1 = phone1
        self.phone = phone
        self.email = email
    }
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case companyName = "company_name"
        case address = "address"
        case city = "city"
        case county = "county"
        case state = "state"
        case zip = "zip"
        case phone1 = "phone1"
        case phone = "phone"
        case email = "email"
    }
}

extension Contact: Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.id == rhs.id
    }
}
