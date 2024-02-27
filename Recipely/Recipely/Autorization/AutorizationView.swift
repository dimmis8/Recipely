// AutorizationView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран входа
final class AutorizationViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let loginText = "Login"
        static let verdanaBold = "Verdana-Bold"
        static let emailText = "Email Adress"
        static let passwordText = "Password"
        static let emailPlaceholder = " Enter Email Address"
        static let passwordPlaceholder = "Enter Password"
        static let incorrectEmail = "Incorrect format"
        static let incorrectPassword = "You entered the wrong password"
        static let emailTextFieldTag = 0
        static let passwordTextFieldTag = 1
    }

    // MARK: - Visual components

    private let gradientLayer = CAGradientLayer()
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.loginText
        label.textColor = .loginText
        label.font = UIFont(name: Constants.verdanaBold, size: 28)
        label.textAlignment = .left
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.emailText
        label.textColor = .loginText
        label.font = UIFont(name: Constants.verdanaBold, size: 18)
        label.textAlignment = .left
        return label
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.passwordText
        label.textColor = .loginText
        label.font = UIFont(name: Constants.verdanaBold, size: 18)
        label.textAlignment = .left
        return label
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.emailPlaceholder
        textField.font = .systemFont(ofSize: 18)
        textField.textAlignment = .left
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.tag = Constants.emailTextFieldTag
        //        textField.addTarget(self, action: #selector(handleTextChange(sender:)), for: .editingDidEnd)
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.passwordPlaceholder
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 18)
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.tag = Constants.passwordTextFieldTag

        //        textField.addTarget(self, action: #selector(handleTextChange(sender:)), for: .editingDidEnd)
        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.loginText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .loginButtons
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(showMainMenu), for: .touchUpInside)
        return button
    }()

    private let incorrectPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.incorrectPassword
        label.textColor = .red
        label.font = UIFont(name: Constants.verdanaBold, size: 12)
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()

    private let incorrectEmailLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.incorrectEmail
        label.textColor = .red
        label.font = UIFont(name: Constants.verdanaBold, size: 12)
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()

    // MARK: - Public Properties

    var presenter: AutorizationViewPresenterProtocol!

    // MARK: - Private Properties

    private let validityTypes: [ValidityType] = [.email, .password]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    // MARK: - Private methods

    private func setupUI() {
        view.layer.addSublayer(gradientLayer)
        view.addSubview(loginLabel)
        view.addSubview(loginButton)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(incorrectEmailLabel)
        view.addSubview(incorrectPasswordLabel)

        emailTextField.addTarget(self, action: #selector(handleTextChange(sender:)), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(handleTextChange(sender:)), for: .editingDidEnd)

        okButton()
        addGradientLayer()
        makeLoginLabelConstants()
        makeLoginButtonConstants()
        makeEmailLabelConstants()
        makeEmailTextFieldsConstants()
        makePasswordLabelConstants()
        makePasswordTextFieldsConstants()
        makeIncorrectPassConstants()
        makeIncorrectEmailConstants()
    }

    private func okButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        toolBar.barStyle = .default
        toolBar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let doneButton = UIBarButtonItem(
            title: "Ok",
            style: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        toolBar.items = [flexSpace, doneButton]
        toolBar.isUserInteractionEnabled = true
        emailTextField.inputAccessoryView = toolBar
        passwordTextField.inputAccessoryView = toolBar
    }

    @objc func doneButtonTapped() {
        view.endEditing(true)
    }

    private func addGradientLayer() {
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor.loginGradient.cgColor
        ]
    }

    private func makeLoginLabelConstants() {
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 82).isActive = true
        loginLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        loginLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    private func makeLoginButtonConstants() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -71).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func makeEmailLabelConstants() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 23).isActive = true
        emailLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    private func makeEmailTextFieldsConstants() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 6).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func makePasswordLabelConstants() {
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 23).isActive = true
        passwordLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    private func makePasswordTextFieldsConstants() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 6).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func makeIncorrectPassConstants() {
        incorrectPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        incorrectPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        incorrectPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        incorrectPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 1)
            .isActive = true
        incorrectPasswordLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
    }

    private func makeIncorrectEmailConstants() {
        incorrectEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        incorrectEmailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        incorrectEmailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        incorrectEmailLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 1).isActive = true
        incorrectEmailLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
    }

    @objc func handleTextChange(sender: UITextField) {
        switch validityTypes[sender.tag] {
        case .email:
            guard let emailText = emailTextField.text else { return }
            if presenter.checkValid(.email, enteringText: emailText) == false {
                incorrectEmailLabel.isHidden = false
                emailLabel.textColor = .red
                emailTextField.layer.borderColor = UIColor.red.cgColor

            } else {
                incorrectEmailLabel.isHidden = true
                emailLabel.textColor = .loginText
                emailTextField.layer.borderColor = UIColor.systemGray5.cgColor
            }
        case .password:
            guard let passwordText = passwordTextField.text else { return }
            if presenter.checkValid(.password, enteringText: passwordText) == false {
                incorrectPasswordLabel.isHidden = false
                passwordLabel.textColor = .red
                passwordTextField.layer.borderColor = UIColor.red.cgColor

            } else {
                incorrectPasswordLabel.isHidden = true
                passwordLabel.textColor = .loginText
                passwordTextField.layer.borderColor = UIColor.systemGray5.cgColor
            }
        }
    }

    // TODO:
    @objc func showMainMenu() {
        print("Show menu")
    }
}

// MARK: - Подписание на протокол экрана авторизации

extension AutorizationViewController: AutorizationViewProtocol {}
