//
//  Storage.swift
//  sushiGarden
//
//  Created by Kirill Sklyarov on 27.06.2024.
//

import Foundation

protocol StorageProtocol {

}

final class Storage: StorageProtocol {

    static let shared = Storage(); private init() { }

    var currentUser: User?

}
