//
//  ExtesnioUIView.swift
//  VoA
//
//  Created by saenglin on 2019/12/30.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
