//
//  ViewController.swift
//  bankey
//
//  Created by Emmanuel Biju on 27/11/24.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    let appTitleLabel = UILabel()
    let appDescriptionLabel = UILabel()
    let loginView = LoginView()
    let loginButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        loginView.usernameTextField.text
    }
    var password: String? {
        loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        loginButton.configuration?.showsActivityIndicator = false
        super.viewWillDisappear(animated)
    }
}

extension LoginViewController {
    
    func style() {
        appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        appTitleLabel.textAlignment = .center
        appTitleLabel.text = "Bankey"
        appTitleLabel.font = UIFont.systemFont(ofSize: 96, weight: .black)
        appTitleLabel.adjustsFontForContentSizeCategory = true
        appTitleLabel.textColor = .black
        
        
        appDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        appDescriptionLabel.textAlignment = .center
        appDescriptionLabel.text = "Your premium solution for all things banking!"
        appTitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        appDescriptionLabel.textColor = .black
        appDescriptionLabel.adjustsFontForContentSizeCategory = true

        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.configuration = .filled()
        loginButton.configuration?.imagePadding = 8
        loginButton.setTitle("Sign In", for: [])
        loginButton.addTarget(self, action: #selector(loginTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.text = ""
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = false
    }
    
    func layout() {
        view.addSubview(appTitleLabel)
        view.addSubview(appDescriptionLabel)
        view.addSubview(loginView)
        view.addSubview(loginButton)
        view.addSubview(errorMessageLabel)
        
        //Title
        NSLayoutConstraint.activate([
            appTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: appTitleLabel.leadingAnchor, multiplier: 1)
        ])
        
        //Description
        NSLayoutConstraint.activate([
            appDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appDescriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: appTitleLabel.bottomAnchor, multiplier: 2),
            appDescriptionLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: appDescriptionLabel.leadingAnchor, multiplier: 1)
        ])
        
        //LoginForm
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: appDescriptionLabel.bottomAnchor, multiplier: 3),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.leadingAnchor, multiplier: 1)
        ])
        
        //LoginButton
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 1),
            loginButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginButton.leadingAnchor, multiplier: 1)
        ])
        
        //ErrorMessage
        NSLayoutConstraint.activate([
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: loginButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: errorMessageLabel.leadingAnchor, multiplier: 1)
        ])
        
    }
}

//MARK: Actions
extension LoginViewController {
    @objc func loginTapped(button: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username,
              let password = password,
              !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showError(withMessage: "Username and password cannot be empty")
            return
        }
        
        if username == "Emmanuel" && password == "Welcome" {
            loginButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            showError(withMessage: "Incorrect username or password!")
        }
    }
    
    private func showError(withMessage message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
    }
}
