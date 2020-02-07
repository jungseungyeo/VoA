//
//  CreateRoomAlertViewController.swift
//  VoA
//
//  Created by saeng lin on 2020/01/30.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

protocol StartArriveAlertViewControllerable: class {
    func confirm(goHomeTime: Int)
    func cancel()
}

class StartArriveAlertViewController: BaseViewController {
    
    static func instance() -> StartArriveAlertViewController {
        return StartArriveAlertViewController.init(nibName: "StartArriveAlertViewController", bundle: nil)
    }
    
    private let viewModel = StartArriveAlertViewModel()
    private let bag = DisposeBag()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dimContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var arriveHomeTimeLabel: UILabel!
    
    @IBOutlet weak var plusTimeBtn: UIButton!
    @IBOutlet weak var minusTimeBtn: UIButton!
    
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    weak var delegate: StartArriveAlertViewControllerable?
    
    private struct Const {
        static let titleString: NSAttributedString = .init(string: "귀가까지 걸리는\n예상 소용시간을 알려주세요.",
                                                           font: .systemFont(ofSize: 16,
                                                                             weight: .bold), color: VoAColor.ArriveHomeAlert.titleColor)
        static let subTitleString: NSAttributedString = .init(string: "시간이 되면 푸시 알림으로 알려드려요",
                                                              font: .systemFont(ofSize: 14,
                                                                                weight: .bold),
                                                              color: VoAColor.ArriveHomeAlert.subTitleColor)
        static let minusBtnImg: UIImage? = UIImage(named: "icMinus")
        static let plucBtnImg: UIImage? = UIImage(named: "icPlus")
        
        static let arriveTimeLabel: NSAttributedString = .init(string: "30분", font: .systemFont(ofSize: 30,
                                                                                                  weight: .bold),
                                                               color: VoAColor.Style.white)
        static let leftGradient: UIColor = VoAColor.AppleLoginAlert.leftGradient
        static let rightGradient: UIColor = VoAColor.AppleLoginAlert.rightGradient
        static let startBtnTitle: NSAttributedString = .init(string: "귀가 시작하기",
                                                             font: .systemFont(ofSize: 18,
                                                                               weight: .bold),
                                                             color: VoAColor.Style.white)
        static let cancelBtnTitle: NSAttributedString = .init(string: "돌아가기",
                                                              font: .systemFont(ofSize: 18,
                                                                                weight: .bold),
                                                              color: VoAColor.Style.white)
    }
    
    override func setup() {
        super.setup()
        
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
        
        setupTitle()
        setupPlusBtn()
        setupMinusBtn()
        setupTimeLabel()
        setupStartBtn()
        setupCanclerBtn()
        setupDimView()
    }
    
    private func setupTitle() {
        titleLabel.attributedText = Const.titleString
        subTitle.attributedText = Const.subTitleString
    }
    
    private func setupPlusBtn() {
        plusTimeBtn.setImage(Const.plucBtnImg, for: .normal)
        plusTimeBtn.tintColor = VoAColor.Style.white
        plusTimeBtn.setTitle("", for: .normal)
        
        plusTimeBtn.rx.tap
            .map { _ in return }
            .bind(to: viewModel.input.updateTimeTapped)
            .disposed(by: bag)
    }
    
    private func setupMinusBtn() {
        minusTimeBtn.setImage(Const.minusBtnImg, for: .normal)
        minusTimeBtn.tintColor = VoAColor.Style.white
        minusTimeBtn.setTitle("", for: .normal)
        
        minusTimeBtn.rx.tap
            .map { _ in return }
            .bind(to: viewModel.input.donwTimeBtnTapped )
            .disposed(by: bag)
    }
    
    private func setupTimeLabel() {
        arriveHomeTimeLabel.attributedText = Const.arriveTimeLabel
        arriveHomeTimeLabel.text = "\(viewModel.goHomeTime)분"
    }
    
    private func setupStartBtn() {
        confirmBtn.setAttributedTitle(Const.startBtnTitle, for: .normal)
        confirmBtn.setWidthGradient(colorLeft: Const.leftGradient,
                                    colorRight: Const.rightGradient)
        confirmBtn.layer.cornerRadius = confirmBtn.frame.size.height / 2
        confirmBtn.clipsToBounds = true
        
        confirmBtn.addTarget(self, action: #selector(confirmBtnTapped(sender:)), for: .touchUpInside)
    }
    
    private func setupCanclerBtn() {
        cancelBtn.addTarget(self, action: #selector(dimTapped), for: .touchUpInside)
        cancelBtn.backgroundColor = VoAColor.ShowStartAlert.cancelBtnColor
        cancelBtn.setAttributedTitle(Const.cancelBtnTitle, for: .normal)
        cancelBtn.clipsToBounds = true
        cancelBtn.layer.cornerRadius = cancelBtn.frame.size.height / 2
        cancelBtn.layer.shadowColor = VoAColor.ShowStartAlert.canclerBtnShadowColor.cgColor
        cancelBtn.layer.shadowRadius = 4
        cancelBtn.layer.shadowOpacity = 1.0
        cancelBtn.layer.masksToBounds = false
        cancelBtn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
    }
    
    private func setupDimView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dimTapped))
        dimContainerView.isUserInteractionEnabled = true
        dimContainerView.addGestureRecognizer(tap)
    }
    
    override func bind() {
        super.bind()
        
        viewModel.output.showGoHomeTime
            .subscribe(onNext: { [weak self] (time) in
                guard let self = self else { return }
                self.arriveHomeTimeLabel.text = "\(time)분"
            }).disposed(by: bag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension StartArriveAlertViewController {
    @objc
    func confirmBtnTapped(sender: UIButton) {
        delegate?.confirm(goHomeTime: viewModel.goHomeTime)
    }
    
    @objc
    func dimTapped() {
        delegate?.cancel()
    }
}
