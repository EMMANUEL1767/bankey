//
//  OnboardingViewController.swift
//  bankey
//
//  Created by Emmanuel Biju on 27/11/24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let heroImageView = UIImageView()
    let stackView = UIStackView()
    let messageView = UILabel()
    
    var heroImageName: String
    var message: String
    
    init(heroImageName: String, message: String) {
        self.message = message
        self.heroImageName = heroImageName
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented - not using storyboards")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}


extension OnboardingViewController {
    func style() {
        view.backgroundColor = .systemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        heroImageView.contentMode = .scaleAspectFit
        heroImageView.image = UIImage(named: heroImageName)
        
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.textAlignment = .center
        messageView.font = UIFont.preferredFont(forTextStyle: .title3)
        messageView.textColor = .black
        messageView.adjustsFontForContentSizeCategory = true   
        messageView.numberOfLines = 0
        messageView.text = message


    }
    
    func layout() {
        stackView.addArrangedSubview(heroImageView)
        stackView.addArrangedSubview(messageView)
        view.addSubview(stackView)
        
                
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
        
        heroImageView.heightAnchor.constraint(equalToConstant: CGFloat(250)).isActive = true

    }
}
