//
//  ContactDataService.swift
//  DemoCSV
//
//  Created by Julio Collado Perez on 3/3/23.
//

import Foundation
import Combine
import CSV

protocol ContactDataProtocol {
    func load() -> AnyPublisher<[Contact], Error>
}

class ContactDataService: ContactDataProtocol {
    
    func load() -> AnyPublisher<[Contact], Error> {
        guard let filepath = Bundle.main.path(forResource: "sample_contacts", ofType: "csv"),
              let csv = try? String(contentsOfFile: filepath) else {
            return Fail(error: CSVError.cannotOpenFile).eraseToAnyPublisher()
        }
        
        var contacts = [Contact]()
        do {
            let reader = try CSVReader(string: csv, hasHeaderRow: true)
            let decoder = CSVRowDecoder()
            while reader.next() != nil {
                let row = try decoder.decode(Contact.self, from: reader)
                contacts.append(row)
            }
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        return Just(contacts).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            debugPrint("❌ \(error.localizedDescription)")
        }
    }
}
