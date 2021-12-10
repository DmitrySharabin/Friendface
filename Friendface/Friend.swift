//
//  Friend.swift
//  Friendface
//
//  Created by Dmitry Sharabin on 10.12.2021.
//

import Foundation


struct Friend: Identifiable, Codable {
    let id: UUID
    let name: String
}
