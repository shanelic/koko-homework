//
//  FriendListViewController.swift
//  koko homework
//
//  Created by Shane Li on 2023/11/12.
//

import Foundation
import UIKit
import SnapKit

class FriendListViewController: UIViewController {
    
    let situation: Situation

    init(situation: Situation) {
        self.situation = situation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    FriendListViewController(situation: .friendsWithInvitations)
}