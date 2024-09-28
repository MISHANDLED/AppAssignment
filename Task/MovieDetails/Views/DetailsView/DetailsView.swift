//
//  DetailsView.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import UIKit

class DetailsView: UIView {
    // MARK: UI Elements
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black55
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black75
        label.numberOfLines = 2
        return label
    }()
    
    private let locationView: IconLabelView = {
        let view = IconLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timingsView: IconLabelView = {
        let view = IconLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        self.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(subtitleLabel)
        mainStackView.addArrangedSubview(locationView)
        mainStackView.addArrangedSubview(timingsView)
                
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            
            locationView.heightAnchor.constraint(equalToConstant: 16),
            timingsView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func configure(with data: ViewModel) {
        titleLabel.text = data.title
        subtitleLabel.text = data.description
        locationView.configure(type: .location, title: data.location)
        timingsView.configure(type: .calender, title: data.showtime)
    }
}


extension DetailsView {
    struct ViewModel {
        let title: String
        let description: String
        let location: String
        let showtime: String
    }
}
