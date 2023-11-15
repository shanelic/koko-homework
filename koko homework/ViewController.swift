//
//  ViewController.swift
//  koko homework
//
//  Created by Shane Li on 2023/11/12.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    private func setupUI() {
        let stack = UIStackView()
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 24
        
        let noFriendButton = UIButton()
        noFriendButton.setTitle("  I have no friend.  ", for: .normal)
        noFriendButton.setTitleColor(.black, for: .normal)
        noFriendButton.layer.borderColor = UIColor.black.cgColor
        noFriendButton.layer.borderWidth = 1.5
        noFriendButton.layer.cornerRadius = 8
        noFriendButton.addTarget(self, action: #selector(performNoFriend), for: .touchUpInside)
        stack.addArrangedSubview(noFriendButton)
        
        let friendsButton = UIButton()
        friendsButton.setTitle("  I have friends.  ", for: .normal)
        friendsButton.setTitleColor(.black, for: .normal)
        friendsButton.layer.borderColor = UIColor.black.cgColor
        friendsButton.layer.borderWidth = 1.5
        friendsButton.layer.cornerRadius = 8
        friendsButton.addTarget(self, action: #selector(performFriends), for: .touchUpInside)
        stack.addArrangedSubview(friendsButton)
        
        let friendsWithInvitationsButton = UIButton()
        friendsWithInvitationsButton.setTitle("  I have friends and also invitations.  ", for: .normal)
        friendsWithInvitationsButton.setTitleColor(.black, for: .normal)
        friendsWithInvitationsButton.layer.borderColor = UIColor.black.cgColor
        friendsWithInvitationsButton.layer.borderWidth = 1.5
        friendsWithInvitationsButton.layer.cornerRadius = 8
        friendsWithInvitationsButton.addTarget(self, action: #selector(performFriendsAndInvitations), for: .touchUpInside)
        stack.addArrangedSubview(friendsWithInvitationsButton)
    }
    
    @objc private func performNoFriend() {
        let vc = FriendListViewController(situation: .noFriend)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func performFriends() {
        let vc = FriendListViewController(situation: .friends)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func performFriendsAndInvitations() {
        let vc = FriendListViewController(situation: .friendsWithInvitations)
        navigationController?.pushViewController(vc, animated: true)
    }

}

enum Situation {
    case noFriend
    case friends
    case friendsWithInvitations
}

#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "root")
}
