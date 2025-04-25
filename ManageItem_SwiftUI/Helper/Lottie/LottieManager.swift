//
//  LottieManager.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/19/25.
//

import SwiftUI
import Lottie

struct ControllableLottieView: UIViewRepresentable {
    let name: String
    var loopMode: LottieLoopMode = .loop
    var speed: CGFloat = 1.0
    @Binding var isPlaying: Bool

    func makeUIView(context: Context) -> UIView {
        let containerView = UIView()
        let animationView = LottieAnimationView(name: name)

        animationView.loopMode = loopMode
        animationView.animationSpeed = speed
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: containerView.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])

        // context에 animationView를 저장
        context.coordinator.animationView = animationView

        if isPlaying {
            animationView.play()
        }

        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let animationView = context.coordinator.animationView else { return }

        if isPlaying {
            if !animationView.isAnimationPlaying {
                animationView.play()
            }
        } else {
            if animationView.isAnimationPlaying {
                animationView.stop()
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator {
        var animationView: LottieAnimationView?
    }
}



