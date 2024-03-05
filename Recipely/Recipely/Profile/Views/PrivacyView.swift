// PrivacyView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран информации о конфиденциальности
final class PrivacyView: UIView {
    // MARK: - Constants

    enum Constants {
        static let titleText = "Terms of Use"
        static let cardHandleAreaHeight: CGFloat = 34
        static let closeHighRatio = 0.85
        static let startCardHeight: CGFloat = 100
    }

    // MARK: - Visual Components

    private let handleArea = UIView()

    private let handleLine: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .line
        return imageView
    }()

    private let termsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleText
        label.font = .verdanaBold(ofSize: 20)
        return label
    }()

    private let privacyTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
        return textView
    }()

    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(.dismissButton, for: .normal)
        return button
    }()

    // MARK: - Private Properties

    private lazy var cardHeight: CGFloat = self.bounds.height - Constants.startCardHeight
    private var cardVisible = false
    private var nextState: CardState {
        cardVisible ? .collapsed : .expanded
    }

    private var runningAnimations: [UIViewPropertyAnimator] = []
    private var animationProgressWhenInterrupted: CGFloat = 0
    private let closeHandler: VoidHandler
    private let privacyText: String

    // MARK: - Initializers

    init(frame: CGRect, privacyText: String, closeHandler: @escaping VoidHandler) {
        self.closeHandler = closeHandler
        self.privacyText = privacyText
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        closeHandler = {}
        privacyText = ""
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 30
        addSubview(handleArea)
        handleArea.addSubview(handleLine)
        addSubview(termsLabel)
        addSubview(privacyTextView)
        addSubview(dismissButton)
        dismissButton.addTarget(self, action: #selector(dismissCard), for: .touchUpInside)
        setText()
        createConstraints()

        clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        handleArea.addGestureRecognizer(tapGestureRecognizer)
        handleArea.addGestureRecognizer(panGestureRecognizer)
    }

    func setText() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 5
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.verdana(ofSize: 14),
            .paragraphStyle: paragraphStyle
        ]
        let attributedText = NSMutableAttributedString(string: privacyText, attributes: attributes)
        privacyTextView.attributedText = attributedText
    }

    private func createConstraints() {
        createHandleAreaConstraints()
        createHandleLineConstraints()
        createTermsLabelConstraints()
        createPrivacyTextViewConstraints()
        createDismissButtonConstraints()
    }

    private func createHandleAreaConstraints() {
        handleArea.translatesAutoresizingMaskIntoConstraints = false
        handleArea.topAnchor.constraint(equalTo: topAnchor).isActive = true
        handleArea.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        handleArea.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        handleArea.heightAnchor.constraint(equalToConstant: Constants.cardHandleAreaHeight).isActive = true
    }

    private func createHandleLineConstraints() {
        handleLine.translatesAutoresizingMaskIntoConstraints = false
        handleLine.topAnchor.constraint(equalTo: handleArea.topAnchor, constant: 15).isActive = true
        handleLine.centerXAnchor.constraint(equalTo: handleArea.centerXAnchor).isActive = true
        handleLine.widthAnchor.constraint(equalToConstant: 50).isActive = true
        handleLine.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }

    private func createTermsLabelConstraints() {
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        termsLabel.topAnchor.constraint(equalTo: handleArea.bottomAnchor, constant: 16).isActive = true
        termsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        termsLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        termsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func createPrivacyTextViewConstraints() {
        privacyTextView.translatesAutoresizingMaskIntoConstraints = false
        privacyTextView.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 14).isActive = true
        privacyTextView.leadingAnchor.constraint(equalTo: termsLabel.leadingAnchor).isActive = true
        privacyTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        privacyTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.cardHandleAreaHeight * 3)
            .isActive = true
    }

    private func createDismissButtonConstraints() {
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    private func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.frame.origin.y = UIScreen.main.bounds.height - self.cardHeight
                case .collapsed:
                    self.frame.origin.y = UIScreen.main.bounds.height - Constants.cardHandleAreaHeight * 3
                }
            }

            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
        }
    }

    private func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }

    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }

    private func continueIntaractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }

    @objc private func handleCardTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.7)
        default:
            break
        }
    }

    @objc private func handleCardPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.7)
        case .changed:
            let translation = recognizer.translation(in: handleArea)
            var fractionComplite = translation.y / (cardHeight - Constants.cardHandleAreaHeight)
            fractionComplite = cardVisible ? fractionComplite : -fractionComplite
            updateInteractiveTransition(fractionCompleted: fractionComplite)
        case .ended:
            runningAnimations.forEach { $0.stopAnimation(true) }
            runningAnimations.removeAll()
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            guard let height = windowScene?.windows.last?.frame.height else { return }

            switch recognizer.location(in: windowScene?.windows.last).y {
            case let location where location > height * Constants.closeHighRatio:
                dismissCard()
            case let location where location > height * 0.5:
                cardVisible = true
                animateTransitionIfNeeded(state: .collapsed, duration: 0.4)
            default:
                cardVisible = false
                animateTransitionIfNeeded(state: .expanded, duration: 0.4)
            }
        default:
            break
        }
    }

    @objc private func dismissCard() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.frame.origin.y = UIScreen.main.bounds.height + Constants.cardHandleAreaHeight
            self?.closeHandler()
        }
    }
}

// MARK: - Добавление состояний карточки

extension PrivacyView {
    enum CardState {
        case expanded
        case collapsed
    }
}
