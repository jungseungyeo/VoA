//
//  NetworkError.swift
//  VoA
//
//  Created by saenglin on 2019/12/31.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import Foundation

import UIKit

class NetworkError: NSObject {
    
    private struct Const {
        static let alertConfirm: String = "확인"
    }
    
    public func alert(vc: UIViewController, error: Error?, action: ((Int) -> Void)?) {
        guard let error = error, let fitpetError = VoAError(rawValue: (error as NSError).code) else {
            unknownError(vc: vc, block: action)
            return
        }
        
        customError(vc: vc, error: fitpetError, action: action)
    }
    
    private func customError(vc: UIViewController, error: VoAError, action: ((Int) -> Void)?) {
        showAlert(vc: vc,
                  title: "\(error)",
                  message: "",
                  error: error,
                  block: action)
    }
    
    private func unknownError(vc: UIViewController, block: ((Int) -> Void)?) {
        showAlert(vc: vc,
                  title: "\(VoAError.unknown)",
                  message: "",
                  error: VoAError.unknown,
                  block: block)
    }
    
    private func showAlert(vc: UIViewController, title: String?, message: String?, error: Error, block: ((Int) -> Void)?) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(.init(title: Const.alertConfirm,
                                  style: .cancel,
                                  handler: { (action) in
                                    block?((error as NSError).code)
            }))
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
