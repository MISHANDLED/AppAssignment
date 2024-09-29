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
    
    private let tagContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .heavy)
        label.textColor = .projectPink
        label.text = "FF"
        return label
    }()
    
    private let tagBorderLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.projectPink.cgColor, UIColor.projectPink.withAlphaComponent(0).cgColor]
        layer.startPoint = CGPoint(x: 0.0, y: 0.5)
        layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return layer
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
        
        tagContainerView.addSubview(tagLabel)
        tagContainerView.addSubview(tagBorderLine)
        
        mainStackView.addArrangedSubview(tagContainerView)
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
            timingsView.heightAnchor.constraint(equalToConstant: 16),
            
            tagLabel.leadingAnchor.constraint(equalTo: tagContainerView.leadingAnchor),
            tagLabel.trailingAnchor.constraint(equalTo: tagContainerView.trailingAnchor),
            tagLabel.topAnchor.constraint(equalTo: tagContainerView.topAnchor, constant: 8),
            tagLabel.bottomAnchor.constraint(equalTo: tagContainerView.bottomAnchor, constant: -8),
            
            tagBorderLine.leadingAnchor.constraint(equalTo: tagContainerView.leadingAnchor),
            tagBorderLine.bottomAnchor.constraint(equalTo: tagContainerView.bottomAnchor),
            tagBorderLine.heightAnchor.constraint(equalToConstant: 1),
            tagBorderLine.widthAnchor.constraint(equalTo: tagContainerView.widthAnchor, multiplier: 0.5),
            
            tagContainerView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
        
        tagBorderLine.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.async { [unowned self] in
            gradientLayer.frame = tagBorderLine.bounds
        }
    }
    
    func configure(with data: ViewModel) {
        titleLabel.text = data.title
        subtitleLabel.text = data.description
        locationView.configure(type: .location, title: data.location)
        timingsView.configure(type: .calender, title: data.showtime)
        
        tagLabel.text = "SPECIAL TAG - \(data.tag.uppercased())"
    }
}


extension DetailsView {
    struct ViewModel {
        let title: String
        let tag: String
        let description: String
        let location: String
        let showtime: String
    }
}
