//
//  FriendCell.swift
//  koko homework
//
//  Created by Shane Li on 2023/11/16.
//

import Foundation
import UIKit

class FriendListCell: UITableViewCell {
    
    var friend: Friend? {
        didSet {
            guard let friend else { return }
            updateUI(friend: friend)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(starIcon)
        starIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
        let avatar = UIImageView(image: .imgFriendsFemaleDefault)
        contentView.addSubview(avatar)
        avatar.snp.makeConstraints { make in
            make.left.equalTo(starIcon.snp.right).offset(6)
            make.height.width.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(avatar.snp.right).offset(15)
        }
    }
    
    private func updateUI(friend: Friend) {
        starIcon.isHidden = !friend.isTop
        nameLabel.text = friend.name
        
        transferButton.removeFromSuperview()
        moreButton.removeFromSuperview()
        inviteLabel.removeFromSuperview()
        
        if friend.status == .invitationSent {
            contentView.addSubview(inviteLabel)
            inviteLabel.snp.makeConstraints { make in
                make.right.centerY.equalToSuperview()
            }
            contentView.addSubview(transferButton)
            transferButton.snp.makeConstraints { make in
                make.right.equalTo(inviteLabel.snp.left).offset(-10)
                make.centerY.equalToSuperview()
            }
        } else {
            contentView.addSubview(moreButton)
            moreButton.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(10)
                make.width.equalTo(18)
                make.height.equalTo(4)
                make.centerY.equalToSuperview()
            }
            contentView.addSubview(transferButton)
            contentView.addSubview(transferButton)
            transferButton.snp.makeConstraints { make in
                make.right.equalTo(moreButton.snp.left).offset(-25)
                make.centerY.equalToSuperview()
            }
        }
    }
    
    lazy var starIcon: UIImageView = {
        let view = UIImageView(image: .icFriendsStar)
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var transferButton: UIView = {
        let label = UILabel()
        label.text = "轉帳"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .hotPink
        
        let container = UIView()
        container.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.left.right.equalToSuperview().inset(10)
        }
        container.layer.borderColor = UIColor.hotPink.cgColor
        container.layer.borderWidth = 1.2
        container.layer.cornerRadius = 2
        
        return container
    }()
    
    lazy var inviteLabel: UIView = {
        let label = UILabel()
        label.text = "邀請中"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .brownGrey
        
        let container = UIView()
        container.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.left.right.equalToSuperview().inset(9)
        }
        container.layer.borderColor = UIColor.pinkishGrey.cgColor
        container.layer.borderWidth = 1.2
        container.layer.cornerRadius = 2
        
        return container
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(.icFriendsMore, for: .normal)
        return button
    }()
}
