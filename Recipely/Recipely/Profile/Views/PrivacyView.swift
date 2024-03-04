// PrivacyView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана ифнормации о приватности
protocol PrivacyViewProtocol: AnyObject {
    ///  Презентер экрана
    var presenter: PrivacyPresenterProtocol? { get set }
}

/// Экран информации о конфиденциальности
final class PrivacyView: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let titleText = "Terms of Use"
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

    // MARK: - Public Properties

    var presenter: PrivacyPresenterProtocol?

    // MARK: - Private Properties

    private let cardHeight: CGFloat = 600
    private let cardHandleAreaHeight: CGFloat = 34
    private var cardVisible = false
    private var nextState: CardState {
        cardVisible ? .collapsed : .expanded
    }

    private var runningAnimations: [UIViewPropertyAnimator] = []
    private var animationProgressWhenInterrupted: CGFloat = 0

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.addSubview(handleArea)
        handleArea.addSubview(handleLine)
        view.addSubview(termsLabel)
        createConstraints()
        view.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        handleArea.addGestureRecognizer(tapGestureRecognizer)
        handleArea.addGestureRecognizer(panGestureRecognizer)
    }

    func createConstraints() {
        createHandleAreaConstraints()
        createHandleLineConstraints()
        createTermsLabelConstraints()
    }

    func createHandleAreaConstraints() {
        handleArea.translatesAutoresizingMaskIntoConstraints = false
        handleArea.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        handleArea.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        handleArea.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        handleArea.heightAnchor.constraint(equalToConstant: cardHandleAreaHeight).isActive = true
    }

    func createHandleLineConstraints() {
        handleLine.translatesAutoresizingMaskIntoConstraints = false
        handleLine.topAnchor.constraint(equalTo: handleArea.topAnchor, constant: 15).isActive = true
        handleLine.centerXAnchor.constraint(equalTo: handleArea.centerXAnchor).isActive = true
        handleLine.widthAnchor.constraint(equalToConstant: 50).isActive = true
        handleLine.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }

    func createTermsLabelConstraints() {
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        termsLabel.topAnchor.constraint(equalTo: handleArea.bottomAnchor, constant: 16).isActive = true
        termsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        termsLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        termsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.view.frame.origin.y = UIScreen.main.bounds.height - self.cardHeight
                case .collapsed:
                    self.view.frame.origin.y = UIScreen.main.bounds.height - self.cardHandleAreaHeight
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
            var fractionComplite = translation.y / (cardHeight - cardHandleAreaHeight)
            fractionComplite = cardVisible ? fractionComplite : -fractionComplite
            updateInteractiveTransition(fractionCompleted: fractionComplite)
        case .ended:
            if recognizer.translation(in: handleArea).y > view.frame.height - cardHandleAreaHeight {
                UIView.animate(withDuration: 0.5) {
                    self.view.frame.origin.y = UIScreen.main.bounds.height
                    // close
                }
            } else {
                continueIntaractiveTransition()
            }
        default:
            break
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

// MARK: - PrivacyView + PrivacyViewProtocol

extension PrivacyView: PrivacyViewProtocol {}
