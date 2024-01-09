//
//  FullScreenClearBackgroundView.swift
//  FetchChallenge
//
//  Created by S J on 1/9/24.
//

import Foundation
import SwiftUI

struct FullScreenClearBackgroundView: UIViewRepresentable {

    init() {}

    func makeUIView(context: Context) -> some UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        view.alpha = 0

        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
