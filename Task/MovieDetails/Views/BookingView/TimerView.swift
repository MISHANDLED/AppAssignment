//
//  TimerView.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import UIKit

class TimerView: UIView {
    // MARK: UI Elements
    private let daysLabel: TimerLabel = {
        let label = TimerLabel(type: .days)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let hoursLabel: TimerLabel = {
        let label = TimerLabel(type: .hours)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let minutesLabel: TimerLabel = {
        let label = TimerLabel(type: .minutes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let secondsLabel: TimerLabel = {
        let label = TimerLabel(type: .seconds)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        self.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        [daysLabel, hoursLabel, minutesLabel, secondsLabel].forEach {
            stack.addArrangedSubview($0)
        }
    }
    
    func configure(days: Int, hours: Int, minutes: Int, seconds: Int) {
        daysLabel.configure(days)
        hoursLabel.configure(hours)
        minutesLabel.configure(minutes)
        secondsLabel.configure(seconds)
    }
}
