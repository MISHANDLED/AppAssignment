//
//  UserImageStackView.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import SDWebImage
import UIKit

final class UserImageStackView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = -8
        return stackView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupViews() {

        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        containerView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stack.topAnchor.constraint(equalTo: containerView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor)
        ])
    }
    
    func configure(with avatars: [String]) {
        avatars.forEach { avatar in
            let image = UserImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.configure(with: avatar)
            
            image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1).isActive = true
            
            stack.addArrangedSubview(image)
            
            image.clipsToBounds = true
            image.layer.cornerRadius = 16
            image.layer.borderWidth = 1
            image.layer.borderColor = UIColor.white.cgColor
        }
    }
}
