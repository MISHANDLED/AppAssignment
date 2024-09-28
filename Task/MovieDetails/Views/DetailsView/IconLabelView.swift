//
//  IconLabelView.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import UIKit

class IconLabelView: UIView {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .projectPink
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray112
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(horizontalStack)
        
        horizontalStack.addArrangedSubview(iconImageView)
        horizontalStack.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            horizontalStack.topAnchor.constraint(equalTo: self.topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor, multiplier: 1)
        ])
    }
    
    func configure(type: LabelType, title: String) {
        label.text = title
        iconImageView.image = UIImage(systemName: type.image)
    }
}


// MARK: LabelType
extension IconLabelView {
    enum LabelType {
        case location
        case calender
        
        var image: String {
            switch self {
            case .location:
                return "house"
            case .calender:
                return "calendar"
            }
        }
    }
}
