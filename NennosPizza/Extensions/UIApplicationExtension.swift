//
//  UIApplicationExtension.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

extension UIApplication {
    enum Direction {
        case top, left, right, bottom
    }

    static func fixedTopSafeAreInset() -> CGFloat {
        return UIApplication.safeAreInset(by: .top) == 0 ? 20 : UIApplication.safeAreInset(by: .top)
    }

    static func safeAreInset(by direction: Direction) -> CGFloat {
        guard let firstWindow = shared.windows.first else {return 0.0}
        if #available(iOS 11.0, *) {
            let insets = firstWindow.safeAreaInsets
            switch direction {
            case .top: return insets.top
            case .bottom: return insets.bottom
            case .left: return insets.left
            case .right: return insets.right
            }
        }

        return 0.0
    }
}
