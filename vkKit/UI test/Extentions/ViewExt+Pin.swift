//
//  ViewExt+Pin.swift
//  UI test
//
//  Created by Nail Safin on 27.03.2020.
//  Copyright © 2020 Nail Safin. All rights reserved.
//

import UIKit
import PinLayout

extension UIView {
    public func pin(to addView: UIView) -> PinLayout<UIView> {
        if !addView.subviews.contains(self) {
            addView.addSubview(self)
        }
        return self.pin
    }
}
