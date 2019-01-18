//
//  ViewExtension.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func viewFromNibForClass(index: Int = 0) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[index] as? UIView
    }

    func initViewFromNib() {
        guard let view = viewFromNibForClass() else { return }
        addSubview(view)
        view.frame = bounds
    }

    func addTapGesture(_ target: Any, action: Selector, delegate: UIGestureRecognizerDelegate? = .none, clearAllOtherGesture clear: Bool = false) {

        if clear {
            gestureRecognizers?.forEach({removeGestureRecognizer($0)})
        }

        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.delegate = delegate
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    func show(in view: UIView, topMargin: CGFloat = 0, bottomMargin: CGFloat = 0, leftMargin: CGFloat = 0, rightMargin: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)

        let constraint1 = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.superview, attribute: .top, multiplier: 1.0, constant: topMargin)
        constraint1.isActive = true

        let constraint2 = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.superview, attribute: .bottom, multiplier: 1.0, constant: 0 - bottomMargin)
        constraint2.isActive = true

        let constraint3 = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.superview, attribute: .leading, multiplier: 1.0, constant: leftMargin)
        constraint3.isActive = true

        let constraint4 = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.superview, attribute: .trailing, multiplier: 1.0, constant: 0 - rightMargin)
        constraint4.isActive = true
    }
}
