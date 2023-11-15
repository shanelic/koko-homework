//
//  FriendListViewModel.swift
//  koko homework
//
//  Created by Shane Li on 2023/11/12.
//

import Foundation
import Alamofire
import PromiseKit

class FriendListViewModel {
    
    weak public var delegate: FriendListDelegate?
}

protocol FriendListDelegate: AnyObject {
    func fetchedData(user: User?)
}