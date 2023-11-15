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
    
    private var friends: [Friend] = []
    var friendList: [Friend] {
        friends
            .filter(\.isFriend)
            .filter { keyword.isEmpty ? true : $0.name.contains(keyword) }
    }
    var invitationList: [Friend] {
        friends
            .filter(\.isInvitation)
    }
    
    public func initial(situation: Situation) {
        switch situation {
        case .noFriend:
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                when(fulfilled: self.fetchUser(), self.fetchFriendList4())
                    .done { users, friends in
                        self.friends = friends
                            .sorted { $0.isTop && !$1.isTop }
                            .sorted { $0.status.rawValue > $1.status.rawValue }
                        self.delegate?.fetchedData(user: users.first)
                    }
                    .cauterize()
            }
        case .friends:
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                when(fulfilled: self.fetchUser(), self.fetchFriendList1(), self.fetchFriendList2())
                    .done { users, friends1, friends2 in
                        var friends = friends1 + friends2
                        for friend in friends {
                            friends.removeAll { $0.friendID == friend.friendID && $0.updateDate < friend.updateDate }
                        }
                        self.friends = friends
                            .sorted { $0.isTop && !$1.isTop }
                            .sorted { $0.status.rawValue > $1.status.rawValue }
                        self.delegate?.fetchedData(user: users.first)
                    }
                    .cauterize()
            }
        case .friendsWithInvitations:
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                when(fulfilled: self.fetchUser(), self.fetchFriendList3())
                    .done { users, friends in
                        self.friends = friends
                            .sorted { $0.isTop && !$1.isTop }
                            .sorted { $0.status.rawValue > $1.status.rawValue }
                        self.delegate?.fetchedData(user: users.first)
                    }
                    .cauterize()
            }
        }
    }
    private func fetchUser() -> Promise<[User]> {
        Promise { seal in
            AF.request("https://dimanyen.github.io/man.json")
                .responseDecodable(of: KokoResponse<[User]>.self) { response in
                    switch response.result {
                    case .success(let data):
                        seal.fulfill(data.response)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }
    
    private func fetchFriendList1() -> Promise<[Friend]> {
        Promise { seal in
            AF.request("https://dimanyen.github.io/friend1.json")
                .responseDecodable(of: KokoResponse<[Friend]>.self) { response in
                    switch response.result {
                    case .success(let data):
                        seal.fulfill(data.response)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }
    
    private func fetchFriendList2() -> Promise<[Friend]> {
        Promise { seal in
            AF.request("https://dimanyen.github.io/friend2.json")
                .responseDecodable(of: KokoResponse<[Friend]>.self) { response in
                    switch response.result {
                    case .success(let data):
                        seal.fulfill(data.response)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }
    
    private func fetchFriendList3() -> Promise<[Friend]> {
        Promise { seal in
            AF.request("https://dimanyen.github.io/friend3.json")
                .responseDecodable(of: KokoResponse<[Friend]>.self) { response in
                    switch response.result {
                    case .success(let data):
                        seal.fulfill(data.response)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }
    
    private func fetchFriendList4() -> Promise<[Friend]> {
        Promise { seal in
            AF.request("https://dimanyen.github.io/friend4.json")
                .responseDecodable(of: KokoResponse<[Friend]>.self) { response in
                    switch response.result {
                    case .success(let data):
                        seal.fulfill(data.response)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }
}

protocol FriendListDelegate: AnyObject {
    func fetchedData(user: User?)
}
