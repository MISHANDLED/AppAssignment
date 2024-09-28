//
//  BookingsView.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import UIKit

final class BookingsView: UIView {
    let containerView: UIView = {
        let viewNeeded = UIView()
        viewNeeded.translatesAutoresizingMaskIntoConstraints = false
        return viewNeeded
    }()
    
    let stack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    let userAvatarView: UserImageStackView = {
        let userImageStackView = UserImageStackView()
        userImageStackView.translatesAutoresizingMaskIntoConstraints = false
        return userImageStackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor.gray112
        label.text = "Booking will close in:"
        return label
    }()

    let subHeadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let timerView: TimerView = {
        let timer = TimerView()
        timer.translatesAutoresizingMaskIntoConstraints = false
        return timer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(stack)
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(timerView)
        stack.addArrangedSubview(userAvatarView)
        stack.addArrangedSubview(subHeadingLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            userAvatarView.heightAnchor.constraint(equalToConstant: 32),
            
//            timerView.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func configure(with data: ViewModel) {
        userAvatarView.configure(with: data.avatars)
        subHeadingLabel.attributedText = generateBookingAttributedString(userCount: data.userCount)
        configure(days: .zero, hours: .zero, minutes: .zero, seconds: .zero)
    }
    
    func configure(days: Int, hours: Int, minutes: Int, seconds: Int) {
        timerView.configure(days: days, hours: hours, minutes: minutes, seconds: seconds)
    }
    
    private func generateBookingAttributedString(userCount: Int) -> NSAttributedString {
        let userCountString: String
        if userCount > 10000 {
            userCountString = "10,000+ Users"
        } else {
            userCountString = "\(userCount) Users"
        }
        
        let attributedString = NSMutableAttributedString()
        
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12, weight: .regular),
            .foregroundColor: UIColor.gray112
        ]
        
        let userCountAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12, weight: .heavy),
            .foregroundColor: UIColor.projectPink
        ]
        
        let normalPart1 = NSAttributedString(string: "Till now ", attributes: normalTextAttributes)
        attributedString.append(normalPart1)
        
        let userCountPart = NSAttributedString(string: userCountString, attributes: userCountAttributes)
        attributedString.append(userCountPart)
        
        let normalPart2 = NSAttributedString(string: " have already booked tickets.", attributes: normalTextAttributes)
        attributedString.append(normalPart2)
        
        return attributedString
    }
}


extension BookingsView {
    struct ViewModel {
        let avatars: [String]
        let userCount: Int
    }
}
