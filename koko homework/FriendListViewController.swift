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
    let viewModel = FriendListViewModel()


    init(situation: Situation) {
        self.situation = situation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.initial(situation: situation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension FriendListViewController: FriendListDelegate {
    func fetchedData(user: User?) {
    }
}

#Preview {
    FriendListViewController(situation: .friendsWithInvitations)
}