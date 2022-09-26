//
//  LoadingView.swift
//  UI_Test_Demo
//
//  Created by nimble on 26/9/22.
//

import Foundation
import UIKit
import SwiftUI

struct LoadingView: UIViewRepresentable {

    typealias UIViewType = UIView

    func makeUIView(context: Context) -> UIView {

        let loadingViewOuter = UIView()
        loadingViewOuter.backgroundColor = .clear
        loadingViewOuter.layer.cornerRadius = 3.0
        
        let loadingViewInner = UIView()
        loadingViewInner.backgroundColor = .green
        loadingViewInner.layer.cornerRadius = 3.0

        loadingViewOuter.addSubview(loadingViewInner)

        loadingViewInner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingViewInner.leadingAnchor.constraint(equalTo: loadingViewOuter.leadingAnchor),
            loadingViewInner.topAnchor.constraint(equalTo: loadingViewOuter.topAnchor),
            loadingViewInner.widthAnchor.constraint(equalToConstant: 360.0),
            loadingViewInner.heightAnchor.constraint(equalTo: loadingViewOuter.heightAnchor)
        ])
        return loadingViewOuter
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let innerView = uiView.subviews.first {
            innerView.frame.size.width = 0
            let animator = UIViewPropertyAnimator(duration: 5.5, curve: .linear, animations: {
                uiView.layoutIfNeeded()
            })
            animator.startAnimation()
        }
    }
}
