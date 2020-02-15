//
//  LeftMenuViewController.swift
//  VoA
//
//  Created by saeng lin on 2020/01/27.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SwiftlyIndicator

enum LeftMenuScetionType: Int, CaseIterable {
    case room = 0
    case etc = 1
    
    var sectionHeigth: CGSize {
        switch self {
        case .room:
            return CGSize(width: UIScreen.main.bounds.width,
                          height: 47)
        default: return .zero
        }
    }
    
    var itemSize: CGSize {
        switch self {
        case .room:
            return CGSize(width: 280, height: 79)
        case .etc:
            return CGSize(width: 280, height: 60)
        }
    }
}

class LeftMenuViewController: BaseViewController {
    
    lazy var leftMenuView: LeftMenuView = {
        let leftMenuView = LeftMenuView(frame: view.bounds)
        
        leftMenuView.collectionView.register(LeftMenuHeaderView.self,
                                             forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                             withReuseIdentifier: LeftMenuHeaderView.registerID)
        
        leftMenuView.collectionView.register(LeftMenuRoomCell.self,
                                             forCellWithReuseIdentifier: LeftMenuRoomCell.registerID)
        leftMenuView.collectionView.register(LeftMenuNewRoomCell.self,
                                             forCellWithReuseIdentifier: LeftMenuNewRoomCell.registerID)
        
        
        leftMenuView.collectionView.delegate = self
        leftMenuView.collectionView.dataSource = self
        return leftMenuView
    }()
    
    private lazy var indicator: SwiftlyIndicator = SwiftlyIndicator(leftMenuView)
    
    private let viewModel: HomeViewModel
    private let bag = DisposeBag()
    
    static func instance(homeViewModel: HomeViewModel) -> LeftMenuViewController {
        return LeftMenuViewController(homeViewModel: homeViewModel)
    }
    
    private init(homeViewModel: HomeViewModel) {
        viewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        view = leftMenuView
        
        if let profileString = UserViewModel.shared.userModel?.profileURL, let profileUrl = URL(string: profileString) {
            leftMenuView.profileImg.kf.setImage(with: profileUrl)
        }
        leftMenuView.userName.text = UserViewModel.shared.userModel?.userName
    }
    
    override func bind() {
        super.bind()
        
        leftMenuView.dismissBtn.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.sideMenuController?.hideLeftViewAnimated()
            }).disposed(by: bag)
        
        viewModel.output.networkState
            .subscribe(onNext: { [weak self] (state) in
                guard let self = self else { return }
                switch state {
                case .request: break
                case .complete:
                    self.leftMenuView.collectionView.reloadData()
                case .error:
                    self.leftMenuView.collectionView.reloadData()
                }
            }).disposed(by: bag)
        
        viewModel.output.dismissLeftMenu
            .subscribe(onNext: { [weak self] (roomID) in
                guard let self = self else { return }
                self.sideMenuController?.hideLeftViewAnimated()
                guard let roomID = roomID else { return }
                self.viewModel.input.requestRoomInfo.accept(roomID)
                
            }).disposed(by: bag)
        
        viewModel.output.moveNoneRoomView
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.sideMenuController?.hideLeftViewAnimated()
                self.viewModel.output.changedView.accept(.noneRoomView)
            }).disposed(by: bag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("leftMenu viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("leftMenu viewDidAppear")
    }
}

extension LeftMenuViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let section = LeftMenuScetionType(rawValue: section) else { return .zero }
        
        return section.sectionHeigth
    }
}

extension LeftMenuViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return LeftMenuScetionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let section = LeftMenuScetionType(rawValue: section) else { return 0 }
        switch section {
        case .room:
            guard let model = viewModel.listRoomDataModels else { return 0 }
            return model.count + 1
        case .etc:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let section = LeftMenuScetionType(rawValue: indexPath.section) else {
            return .zero
        }
        
        return section.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: LeftMenuHeaderView.registerID, for: indexPath) as? LeftMenuHeaderView else {
                                                                            return UICollectionReusableView()
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let section = LeftMenuScetionType(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        switch section {
        case .room:
            if let model = viewModel.listRoomDataModels, model.count == indexPath.row {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeftMenuNewRoomCell.registerID, for: indexPath) as? LeftMenuNewRoomCell else {
                    return UICollectionViewCell()
                }
                cell.rx.newRoomCellTapped
                    .map { _ -> Int in
                        return indexPath.row
                }.bind(to: viewModel.input.newCellTapped)
                    .disposed(by: cell.bag)
                
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeftMenuRoomCell.registerID, for: indexPath) as? LeftMenuRoomCell else {
                    return UICollectionViewCell()
                }
                cell.bind(titleString: viewModel.listRoomDataModels?[safe: indexPath.row]?.roomTitle)
                
                cell.rx.leftRoomTapped
                    .map { _ -> Int in
                        return indexPath.row
                }.bind(to: viewModel.input.roomCellTapped)
                    .disposed(by: cell.bag)
                
                return cell
            }
        case .etc:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeftMenuNewRoomCell.registerID, for: indexPath) as? LeftMenuNewRoomCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
    
    
}

