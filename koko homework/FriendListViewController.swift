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
        setupUI()
        viewModel.delegate = self
        viewModel.initial(situation: situation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        navigationItem.setLeftBarButtonItems([
            .init(image: .icNavPinkWithdraw.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back)),
            .init(image: .icNavPinkTransfer.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil),
        ], animated: true)
        navigationItem.setRightBarButtonItems([
            .init(image: .icNavPinkScan.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        ], animated: true)
        navigationItem.titleView?.tintColor = .hotPink
        
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        
        let profileView = UIView()
        topView.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview().inset(30)
        }
        
        let avatarView = UIImageView(image: .imgFriendsFemaleDefault)
        profileView.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.centerY.right.equalToSuperview()
            make.height.equalTo(54)
            make.width.equalTo(52)
            make.top.bottom.equalToSuperview()
        }
        
        let userInfo = UIView()
        profileView.addSubview(userInfo)
        userInfo.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview()
        }
        
        userInfo.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        userInfo.addSubview(kokoID)
        kokoID.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview()
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
        }
        
        let kokoIDIcon = UIImageView(image: .init(systemName: "chevron.right"))
        kokoIDIcon.tintColor = .greyishBrown
        userInfo.addSubview(kokoIDIcon)
        kokoIDIcon.snp.makeConstraints { make in
            make.height.centerY.equalTo(kokoID)
            make.left.equalTo(kokoID.snp.right).offset(4)
        }
        
        topView.addSubview(invitations)
        invitations.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(25)
            make.left.right.equalToSuperview()
            make.height.equalTo(0)
        }
        
        let tabs = UIView()
        topView.addSubview(tabs)
        tabs.snp.makeConstraints { make in
            make.top.equalTo(invitations.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalToSuperview()
        }
        
        tabs.addSubview(friendsTab)
        friendsTab.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
        }
        
        let friendsTitle = UILabel()
        friendsTitle.text = "好友"
        friendsTitle.font = .systemFont(ofSize: 13, weight: .medium)
        friendsTitle.textColor = .greyishBrown
        friendsTab.addSubview(friendsTitle)
        friendsTitle.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        
        let friendsBottomBar = UIView()
        friendsBottomBar.backgroundColor = .hotPink
        friendsBottomBar.layer.cornerRadius = 2
        friendsTab.addSubview(friendsBottomBar)
        friendsBottomBar.snp.makeConstraints { make in
            make.top.equalTo(friendsTitle.snp.bottom).offset(6)
            make.left.right.equalTo(friendsTitle).inset(3)
            make.height.equalTo(4)
        }
        
        tabs.addSubview(chatsTab)
        chatsTab.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(friendsTab.snp.right).offset(36)
        }
        
        let chatsTitle = UILabel()
        chatsTitle.text = "聊天"
        chatsTitle.font = .systemFont(ofSize: 13, weight: .regular)
        chatsTitle.textColor = .greyishBrown
        chatsTab.addSubview(chatsTitle)
        chatsTitle.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        
        view.addSubview(toolbar)
        toolbar.isHidden = true
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(8)
            make.right.equalToSuperview().inset(30)
            make.left.equalToSuperview().inset(22)
        }
        
        let searchbar = UISearchBar()
        searchbar.placeholder = "想轉一筆給誰呢？"
        searchbar.searchTextField.font = .systemFont(ofSize: 14, weight: .regular)
        searchbar.enablesReturnKeyAutomatically = false
        searchbar.backgroundImage = UIImage()
        searchbar.delegate = self
        toolbar.addSubview(searchbar)
        searchbar.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview()
        }
        
        let addFriend = UIButton()
        addFriend.setImage(.icBtnAddFriends, for: .normal)
        toolbar.addSubview(addFriend)
        addFriend.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.centerY.right.equalToSuperview()
            make.left.equalTo(searchbar.snp.right).offset(15)
        }
        
        view.addSubview(friendList)
        friendList.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            if let height = tabBarController?.tabBar.frame.height {
                make.bottom.equalToSuperview().inset(height + 16)
            } else {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(5)
            }
        }
    }
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 252 / 255.0, alpha: 1.0)
        return view
    }()
    
    lazy private var usernameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .greyishBrown
        label.text = "姓名"
        return label
    }()
    
    lazy private var kokoID: UILabel = {
        let label = UILabel()
        label.text = "設定 KOKO ID"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .greyishBrown
        return label
    }()
    
    lazy var invitations: UIView = {
        return UIView()
    }()
    
    lazy var emptyView: UIView = {
        let view = UIView()
        
        let image = UIImageView(image: .imgFriendsEmpty)
        image.contentMode = .scaleAspectFit
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.left.right.equalToSuperview().inset(65)
        }
        
        let label = UILabel()
        label.text = "就從加好友開始吧：）"
        label.textColor = .greyishBrown
        label.font = .systemFont(ofSize: 21, weight: .medium)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(41)
            make.centerX.equalToSuperview()
        }
        
        let content = UILabel()
        content.text = "與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）"
        content.textAlignment = .center
        content.numberOfLines = 0
        content.font = .systemFont(ofSize: 14, weight: .regular)
        content.textColor = .brownGrey
        view.addSubview(content)
        content.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        let addFriendButton = UIView()
        addFriendButton.backgroundColor = .frogGreen
        addFriendButton.layer.cornerRadius = 20
        addFriendButton.layer.shadowColor = UIColor.appleGreen40.cgColor
        addFriendButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        addFriendButton.layer.shadowRadius = 20
        addFriendButton.layer.masksToBounds = false
        view.addSubview(addFriendButton)
        addFriendButton.snp.makeConstraints { make in
            make.top.equalTo(content.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(92)
        }
        
        let buttonTitle = UILabel()
        buttonTitle.text = "加好友"
        buttonTitle.textColor = .white
        buttonTitle.font = .systemFont(ofSize: 16, weight: .medium)
        addFriendButton.addSubview(buttonTitle)
        buttonTitle.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(9)
            make.center.equalToSuperview()
        }
        
        let buttonIcon = UIImageView(image: .icAddFriendWhite)
        addFriendButton.addSubview(buttonIcon)
        buttonIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(8)
            make.height.width.equalTo(24)
        }
        
        let findingHint = UILabel()
        let attributedString = NSMutableAttributedString(string: "幫助好友更快找到你？設定 KOKO ID")
        attributedString.addAttribute(.foregroundColor, value: UIColor.brownGrey, range: NSRange(location: 0, length: 10))
        attributedString.addAttribute(.foregroundColor, value: UIColor.hotPink, range: NSRange(location: 10, length: 10))
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 10, length: 10))
        findingHint.attributedText = attributedString
        findingHint.font = .systemFont(ofSize: 13, weight: .regular)
        view.addSubview(findingHint)
        findingHint.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
        }
        
        return view
    }()
    
    lazy var friendsTab: UIView = {
        return UIView()
    }()
    
    lazy var chatsTab: UIView = {
        return UIView()
    }()
    
    lazy var toolbar: UIView = {
        return UIView()
    }()
    
    lazy var friendList: UITableView = {
        let table = UITableView()
        table.separatorInset.left = 85
        table.dataSource = self
        table.register(FriendListCell.self, forCellReuseIdentifier: "FriendCell")
        table.rowHeight = 60
        table.allowsSelection = false
        return table
    }()
}

extension FriendListViewController: FriendListDelegate {
    func fetchedData(user: User?) {
        usernameLabel.text = user?.name
        kokoID.text = "KOKO ID：\(user?.kokoid ?? "")"
        
        emptyView.isHidden = !viewModel.friendList.isEmpty
        toolbar.isHidden = viewModel.friendList.isEmpty
        friendList.isHidden = viewModel.friendList.isEmpty
        
        for subview in invitations.subviews {
            subview.removeFromSuperview()
        }
        for (index, invitation) in viewModel.invitationList.enumerated() {
            let invitationView = UIView()
            invitationView.backgroundColor = .white
            invitationView.layer.cornerRadius = 6
            invitationView.layer.masksToBounds = false
            invitationView.layer.shadowColor = UIColor.black10.cgColor
            invitationView.layer.shadowOpacity = 1
            invitationView.layer.shadowOffset = CGSize(width: 0, height: 4)
            invitationView.layer.shadowRadius = 6
            invitationView.layer.zPosition = 1
            
            let avatar = UIImageView(image: .imgFriendsFemaleDefault)
            invitationView.addSubview(avatar)
            avatar.snp.makeConstraints { make in
                make.top.left.bottom.equalToSuperview().inset(15)
                make.height.width.equalTo(40)
            }
            
            let name = UILabel()
            name.text = invitation.name
            name.font = .systemFont(ofSize: 16, weight: .regular)
            name.textColor = .greyishBrown
            invitationView.addSubview(name)
            name.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(14)
                make.left.equalTo(avatar.snp.right).offset(15)
            }
            
            let content = UILabel()
            content.text = "邀請你成為好友：）"
            content.font = .systemFont(ofSize: 13, weight: .regular)
            content.textColor = .brownGrey
            invitationView.addSubview(content)
            content.snp.makeConstraints { make in
                make.left.equalTo(avatar.snp.right).offset(15)
                make.bottom.equalToSuperview().inset(14)
            }
            
            let refuse = UIImageView(image: .btnFriendsDelet)
            invitationView.addSubview(refuse)
            refuse.snp.makeConstraints { make in
                make.height.width.equalTo(30)
                make.right.equalToSuperview().inset(15)
                make.centerY.equalToSuperview()
            }
            
            let accept = UIImageView(image: .btnFriendsAgree)
            invitationView.addSubview(accept)
            accept.snp.makeConstraints { make in
                make.height.width.equalTo(30)
                make.right.equalTo(refuse.snp.left).offset(-15)
                make.centerY.equalToSuperview()
            }
            
            invitations.addSubview(invitationView)
            invitationView.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(30)
                make.top.equalToSuperview().inset(index * 80 - 10)
            }
        }
        invitations.snp.updateConstraints { make in
            if viewModel.invitationList.isEmpty {
                make.height.equalTo(0)
            } else {
                make.height.equalTo(viewModel.invitationList.count * 80 - 10)
            }
        }
        
        if !viewModel.friendList.isEmpty {
            let chatBadge = UIView()
            chatBadge.layer.cornerRadius = 9
            chatBadge.backgroundColor = .softPink
            let label = UILabel()
            label.text = " 99+ "
            label.font = .systemFont(ofSize: 12, weight: .medium)
            label.textColor = .white
            chatBadge.addSubview(label)
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(3)
            }
            chatsTab.addSubview(chatBadge)
            chatBadge.snp.makeConstraints { make in
                make.left.equalTo(chatsTab.snp.right)
                make.centerY.equalTo(chatsTab.snp.top)
            }
            let invitationCount = viewModel.friendList.filter { $0.status == .invitationSent }.count
            if invitationCount > 0 {
                let friendBadge = UIView()
                friendBadge.layer.cornerRadius = 9
                friendBadge.backgroundColor = .softPink
                let label = UILabel()
                label.text = " \(invitationCount) "
                label.font = .systemFont(ofSize: 12, weight: .medium)
                label.textColor = .white
                friendBadge.addSubview(label)
                label.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(3)
                }
                friendsTab.addSubview(friendBadge)
                friendBadge.snp.makeConstraints { make in
                    make.centerX.equalTo(friendsTab.snp.right).offset(12)
                    make.centerY.equalTo(friendsTab.snp.top)
                }
            }
        }
        friendList.reloadData()
    }
}

extension FriendListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        if let cell = cell as? FriendListCell {
            cell.friend = viewModel.friendList[indexPath.row]
        }
        return cell
    }
}

#Preview {
    FriendListViewController(situation: .friendsWithInvitations)
}