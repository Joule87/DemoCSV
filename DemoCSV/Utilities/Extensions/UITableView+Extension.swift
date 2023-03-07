//
//  UITableView+Extension.swift
//  DemoCSV
//
//  Created by Julio Collado Perez on 3/4/23.
//

import UIKit
import Combine

extension UITableView {
    func createBinding<T>(with subject: Published<T>.Publisher,
                          completion: @escaping ((Published<T>.Publisher.Output) -> Void),
                          storeIn subscriptions: inout Set<AnyCancellable>) {
        
        subject.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                debugPrint("❌ \(error.localizedDescription)")
            }
        }, receiveValue: completion)
        .store(in: &subscriptions)
    }
}
