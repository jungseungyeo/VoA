//
//  MemberInviteViewController.swift
//  VoA
//
//  Created by saeng lin on 2020/01/31.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class MemberInviteViewController: BaseViewController {
    
    static func instance(viewModel: MemberInviteViewModel) -> MemberInviteViewController {
        return MemberInviteViewController(memberInviteViewModel: viewModel)
    }
    
    private let viewModel: MemberInviteViewModel
    
    private lazy var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(named: "back"),
                                  style: .plain,
                                  target: self,
                                  action: #selector(backTapped(sender:)))
        btn.tintColor = VoAColor.Style.white
        return btn
    }()
    
    private init(memberInviteViewModel: MemberInviteViewModel) {
        viewModel = memberInviteViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var memberInviteView: MemberInviteView = {
        let memberInviteView = MemberInviteView(frame: view.bounds)
        return memberInviteView
    }()
    
    override func setup() {
        super.setup()
        
        view = memberInviteView
        setupNavigation()
        setupCollectionView()
    }
    
    private func setupNavigation() {
        setupTitle("맴버 초대하기",
                   color: VoAColor.Style.white,
                   font: .systemFont(ofSize: 16,
                                     weight: .bold))
        
        navigationItem.leftBarButtonItem = backBtn
    }
    
    private func setupCollectionView() {
        memberInviteView.memberCollectionView.delegate = self
        memberInviteView.memberCollectionView.dataSource = self
        
        memberInviteView.memberCollectionView.register(MemberInviteHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MemberInviteHeaderView.registerID)
        memberInviteView.memberCollectionView.register(MemberInviteCollectionViewCell.self, forCellWithReuseIdentifier: MemberInviteCollectionViewCell.registerID)
        
    }
    
    override func bind() {
        super.bind()
    }
}

private extension MemberInviteViewController {
    @objc
    func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

extension MemberInviteViewController: UICollectionViewDelegateFlowLayout {
    
}

extension MemberInviteViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MemberInviteHeaderView.registerID, for: indexPath) as? MemberInviteHeaderView else {
            return UICollectionReusableView()
        }
        
        header.rx.kakaoInviteBtnTapped
            .bind(to: viewModel.input.kakaoInviteBntTapped)
            .disposed(by: header.bag)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberInviteCollectionViewCell.registerID, for: indexPath) as? MemberInviteCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}
