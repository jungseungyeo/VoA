//
//  HomeViewController.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/20.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SwiftlyIndicator

class HomeNavigationViewController: BaseNaivgationController {
    
}

class HomeViewController: BaseViewController {
    
    static func instance(homeViewModel: HomeViewModel) -> HomeViewController {
        return HomeViewController(homeViewModel: homeViewModel)
    }
    
    private lazy var noneRoomView: NoneRoomView? = {
        let noneRoomView = NoneRoomView.instanceFromNib()
        noneRoomView?.delegate = self
        return noneRoomView
    }()
    
    private lazy var startingRoomView: StartingRoomView = {
        let startingRoomView = StartingRoomView(frame: view.bounds)
        startingRoomView.collectionView.delegate = self
        startingRoomView.collectionView.dataSource = self
        
        startingRoomView.collectionView.addSubview(refreshControl)
        
        startingRoomView.collectionView.register(StartingRoomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StartingRoomHeaderView.registerID)
        startingRoomView.collectionView.register(StartingMemeberHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StartingMemeberHeaderView.registerID)
        startingRoomView.collectionView.register(StartingRoomEndHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StartingRoomEndHeaderView.registerID)
        
        startingRoomView.collectionView.register(StartingMemeberCollectionCell.self, forCellWithReuseIdentifier: StartingMemeberCollectionCell.registerID)
        startingRoomView.collectionView.register(StartingRoomEndMemeberCollectionViewCell.self, forCellWithReuseIdentifier: StartingRoomEndMemeberCollectionViewCell.registerID)
        
        return startingRoomView
    }()
    
    private lazy var menuBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(named: "menu"),
                                  style: .plain,
                                  target: self,
                                  action: #selector(menuTapped(sender:)))
        btn.tintColor = VoAColor.Style.white
        return btn
    }()
    
    private lazy var logoBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "다옴",
                                  style: .plain, target: nil, action: nil)
        btn.setTitleTextAttributes([.foregroundColor : VoAColor.Home.logoColor,
                                    .font: UIFont.systemFont(ofSize: 20,
                                                             weight: .bold)],
                                   for: .disabled)
        btn.isEnabled = false
        return btn
    }()
    
    private lazy var indicator: SwiftlyIndicator = .init(view)
    
    private let viewModel: HomeViewModel
    private let bag = DisposeBag()
    
    init(homeViewModel: HomeViewModel) {
        viewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private struct Const {
        
    }
    
    override func setup() {
        super.setup()
        
        navigationItem.leftBarButtonItems = [menuBtn, logoBtn]
        
    }
    
    override func bind() {
        super.bind()
        
        viewModel.output.createBtnAction
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.navigationController?.pushViewController(CreateRoomViewController.instance(),
                                                              animated: true)
            }).disposed(by: bag)
        
        viewModel.output.networkState
            .subscribe(onNext: { [weak self] (state) in
                guard let self = self else { return }
                switch state {
                case .request:
                    self.indicator.start()
                case .complete:
                    self.indicator.stop()
                case .error(let error):
                    self.handleError(error: error)
                }
                
            }).disposed(by: bag)
        
        viewModel.output.changedView
            .skip(1)
            .subscribe(onNext: { [weak self] (state) in
                guard let self = self else { return }
                switch state {
                case .noneRoomView:
                    self.navigationItem.leftBarButtonItems = [self.menuBtn, self.logoBtn]
                    self.view = self.noneRoomView
                case .noneStartRoomView:
                    print("noneStartRoomView")
                case .startingRoomView:
                    self.view = self.startingRoomView
                    self.configueStartingRoomView()
                    self.startingRoomView.collectionView.reloadData()
                }
                
            }).disposed(by: bag)
        
        viewModel.input.request.accept(())
    }
    
    private func configueStartingRoomView() {
        logoBtn.title = viewModel.roomInfoModel?.roomTItle
    }
    
    override func handleError(error: Error?) {
        super.handleError(error: error)
    }
    
    override func handleRefresh(_ sender: UIRefreshControl) {
        super.handleRefresh(sender)
        
        viewModel.input.request.accept(())
    }
}

private extension HomeViewController {
    @objc
    func menuTapped(sender: UIBarButtonItem) {
        sideMenuController?.showLeftViewAnimated()
    }
}

extension HomeViewController: NoneRoomViewable {
    func createBtnTapped() {
        viewModel.input.createRoomBtnTapped.accept(())
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch viewModel.output.changedView.value {
        case .noneRoomView:
            return .zero
        case .noneStartRoomView:
            return .zero
        case .startingRoomView:
            return startingCollectionView(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.output.changedView.value {
        case .noneRoomView:
            return .zero
        case .noneStartRoomView:
            return .zero
        case .startingRoomView:
            return startingCollectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch viewModel.output.changedView.value {
        case .noneRoomView:
            return 0
        case .noneStartRoomView:
            return 0
        case .startingRoomView:
            return startingNumberOfSections(in: collectionView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch viewModel.output.changedView.value {
        case .noneRoomView:
            return 0
        case .noneStartRoomView:
            return 0
        case .startingRoomView:
            return startingCollectionView(collectionView, numberOfItemsInSection: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch viewModel.output.changedView.value {
        case .noneRoomView:
            return UICollectionReusableView()
        case .noneStartRoomView:
            return UICollectionReusableView()
        case .startingRoomView:
            return startingCollectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.output.changedView.value {
        case .noneRoomView:
            return UICollectionViewCell()
        case .noneStartRoomView:
            return UICollectionViewCell()
        case .startingRoomView:
            return startingCollectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    
}

// StartingHomeViewController
private extension HomeViewController {
    
    func startingNumberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionCount 
    }
    
    func startingCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = StartingRoomViewSection(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .myStatus:
            return 0
        case .memberStatus:
            return viewModel.normalParticipants?.count ?? 0
        case .endMemberStatus:
            return viewModel.endParticipants?.count ?? 0
        }
    }
    
    func startingCollectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        guard let staringViewSection = StartingRoomViewSection(rawValue: section) else {
            return .zero
        }
        
        switch staringViewSection {
        case .myStatus:
            return CGSize(width: UIScreen.main.bounds.width,
                          height: 110)
        default:
            return CGSize(width: UIScreen.main.bounds.width,
                          height: 45)
        }
    }
    
    func startingCollectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let stringViewSection = StartingRoomViewSection(rawValue: indexPath.section) else {
            return .zero
        }
        switch stringViewSection {
        case .myStatus:
            return .zero
        case .memberStatus:
            return CGSize(width: UIScreen.main.bounds.width,
                          height: 98)
        case .endMemberStatus:
            return CGSize(width: UIScreen.main.bounds.width,
                          height: 98)
        }
    }
    
    func startingCollectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let stringViewSection = StartingRoomViewSection(rawValue: indexPath.section) else {
            return UICollectionReusableView()
        }
        
        switch stringViewSection {
        case .myStatus:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StartingRoomHeaderView.registerID, for: indexPath) as? StartingRoomHeaderView else {
                return UICollectionReusableView()
            }
            header.bind(myName: viewModel.myInfo?.userName,
                        myStatus: viewModel.myInfo?.userStatus,
                        remainingTime: 30)
            return header
        case .memberStatus:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StartingMemeberHeaderView.registerID, for: indexPath) as? StartingMemeberHeaderView else {
                return UICollectionReusableView()
            }
            header.bind(memberCount: viewModel.normalParticipants?.count)
            return header
        case .endMemberStatus:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StartingRoomEndHeaderView.registerID, for: indexPath) as? StartingRoomEndHeaderView else {
                return UICollectionReusableView()
            }
            header.bind(memberCount: viewModel.endParticipants?.count)
            return header
        }
    }
    
    func startingCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let stringViewSection = StartingRoomViewSection(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch stringViewSection {
        case .myStatus:
            return UICollectionViewCell()
        case .memberStatus:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartingMemeberCollectionCell.registerID, for: indexPath) as? StartingMemeberCollectionCell else {
                return UICollectionViewCell()
            }
            
            cell.bind(name: viewModel.getMemberName(index: indexPath.item),
                      profileURLstring: viewModel.getMemberProfiletUrlString(index: indexPath.row),
                      remindTime: viewModel.getMemberRemindTime(index: indexPath.item),
                      goHomeTime: viewModel.getMemberGoHomeTime(index: indexPath.item),
                      isMessage: viewModel.isMemberMessage(index: indexPath.item),
                      userStatus: viewModel.getMemberStatus(index: indexPath.item))
            
            return cell
        case .endMemberStatus:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartingRoomEndMemeberCollectionViewCell.registerID, for: indexPath) as? StartingRoomEndMemeberCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.bind(name: viewModel.getEndMemberName(index: indexPath.item),
                      profileURLstring: viewModel.getEndMemberProfiletUrlString(index: indexPath.item),
                      remindTime: viewModel.getEndMemberRemindTime(index: indexPath.row),
                      goHomeTime: viewModel.getMemberGoHomeTime(index: indexPath.row),
                      isMessage: viewModel.isEndMemberMessage(index: indexPath.row),
                      userStatus: viewModel.getEndMemberStatus(index: indexPath.row))
            
            return cell
        }
    }
    
}
