//
//  LoadingView.swift
//  UikitInSwiftUI
//
//  Created by Taher on 19/9/22.
//

import Foundation
import SwiftUI
import UIKit

struct LoadingView: UIViewRepresentable {

    @Binding var isLoading: Bool

    typealias UIViewType = UIStackView

    func makeUIView(context: Context) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5.0

        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .black

        let loadingView = UIView()
        loadingView.backgroundColor = .black
        loadingView.layer.cornerRadius = 1.0

        stackView.addArrangedSubview(activityIndicator)
        stackView.addArrangedSubview(loadingView)

        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 10.0),
            loadingView.heightAnchor.constraint(equalToConstant: 5.0)
        ])
        return stackView
    }

    func updateUIView(_ uiView: UIStackView, context: Context) {
        if isLoading {
            if let activityIndicator = uiView.subviews.first as? UIActivityIndicatorView {
                activityIndicator.startAnimating()
            }
            if let loadingView = uiView.subviews.last {
                loadingView.isHidden = false
                let animator = UIViewPropertyAnimator(duration: 10.0, curve: .linear, animations: {
                    loadingView.transform = CGAffineTransform(scaleX: 8.0, y: 1.0)
                })
                animator.startAnimation()
            }
        } else {
            if let activityIndicator = uiView.subviews.first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
            }
            if let loadingView = uiView.subviews.last {
                loadingView.isHidden = true
                loadingView.transform = CGAffineTransform(scaleX: 0.0, y: 1.0)
            }
        }
    }
}

struct NewLoadingView: UIViewRepresentable {

    @Binding var isLoading: Bool

    typealias UIViewType = UIStackView

    func makeUIView(context: Context) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5.0

        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .black

        let loadingViewOuter = UIView()
        loadingViewOuter.backgroundColor = .black
        loadingViewOuter.layer.cornerRadius = 3.0

        let loadingViewInner = UIView()
        loadingViewInner.backgroundColor = .green
        loadingViewInner.layer.cornerRadius = 3.0

        loadingViewOuter.addSubview(loadingViewInner)
        loadingViewInner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingViewInner.leadingAnchor.constraint(equalTo: loadingViewOuter.leadingAnchor),
            loadingViewInner.topAnchor.constraint(equalTo: loadingViewOuter.topAnchor),
            loadingViewInner.widthAnchor.constraint(equalTo: loadingViewOuter.widthAnchor),
            loadingViewInner.heightAnchor.constraint(equalTo: loadingViewOuter.heightAnchor)
        ])

        stackView.addArrangedSubview(activityIndicator)
        stackView.addArrangedSubview(loadingViewOuter)

        loadingViewOuter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingViewOuter.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            loadingViewOuter.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            loadingViewOuter.heightAnchor.constraint(equalToConstant: 6.0)
        ])
        return stackView
    }

    func updateUIView(_ uiView: UIStackView, context: Context) {
        if isLoading {
            if let activityIndicator = uiView.subviews.first as? UIActivityIndicatorView {
                activityIndicator.startAnimating()
            }
            if let loadingView = uiView.subviews.last {
                loadingView.isHidden = false
                if let innerLoadingView = loadingView.subviews.first {
                    innerLoadingView.frame.size.width = 0.0
                    let animator = UIViewPropertyAnimator(duration: 10.0, curve: .linear, animations: {
                        loadingView.layoutIfNeeded()
                    })
                    animator.startAnimation()
                }
            }
        } else {
            if let activityIndicator = uiView.subviews.first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
            }
            if let loadingView = uiView.subviews.last {
                loadingView.isHidden = true
            }
        }
    }
}
