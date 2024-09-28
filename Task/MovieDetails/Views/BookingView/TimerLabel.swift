//
//  TimerLabel.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import UIKit

final class TimerLabel: UIView {
    // MARK: UI Elements
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBackground
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 Hours"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.anotherPink
        return label
    }()
    
    
    // MARK: Data Varaibles
    private let type: DateType
    
    init(type: DateType) {
        self.type = type
        super.init(frame: .zero)
        
        setupViews()
    }
    
    override init(frame: CGRect) {
        fatalError()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        self.addSubview(containerView)
        containerView.addSubview(timeLabel)
        
        // Constraints for the container and vertical stack
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            timeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
        
        timeLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    func configure(_ newValue: Int) {
        timeLabel.attributedText = createAttributedTimeString(time: newValue)
    }
    
    private func createAttributedTimeString(time: Int) -> NSAttributedString {
        let textColor = UIColor.anotherPink
        
        let timeAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: textColor
        ]
        
        let unitAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12, weight: .bold),
            .foregroundColor: textColor
        ]
        
        let attributedString = NSMutableAttributedString(string: "\(time)", attributes: timeAttributes)
        
        let spacing = NSAttributedString(string: " ")
        attributedString.append(spacing)
        
        let unitAttributedString = NSAttributedString(string: type.description, attributes: unitAttributes)
        attributedString.append(unitAttributedString)
        
        return attributedString
    }
}

extension TimerLabel {
    enum DateType: CustomStringConvertible {
        case days
        case hours
        case minutes
        case seconds
        
        var description: String {
            switch self {
            case .days:
                return "Days"
            case .hours:
                return "Hours"
            case .minutes:
                return "Mins"
            case .seconds:
                return "Sec"
            }
        }
    }
}
