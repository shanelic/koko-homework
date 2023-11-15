//
//  Models.swift
//  koko homework
//
//  Created by Shane Li on 2023/11/12.
//

import Foundation

struct User: Codable {
    let name: String
    let kokoid: String
}

struct Friend: Codable {
    let name: String
    let status: Status
    var isFriend: Bool { status != .invitationReceived }
    var isInvitation: Bool { status == .invitationReceived }
    var isTop: Bool { _isTop == "1" }
    private let _isTop: String
    let friendID: String
    private let _updateDate: String
    var updateDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        if let date = formatter.date(from: _updateDate) {
            return date
        }
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date(from: _updateDate)!
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case status
        case _isTop = "isTop"
        case friendID = "fid"
        case _updateDate = "updateDate"
    }
    
    enum Status: Int, Codable {
        case invitationSent = 2
        case invitationReceived = 0
        case normal = 1
    }
}

struct KokoResponse<T>: Codable where T: Codable {
    let response: T
}
