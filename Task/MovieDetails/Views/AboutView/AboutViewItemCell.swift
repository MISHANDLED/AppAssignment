//
//  AboutViewItemCella.swift
//  Task
//
//  Created by Devansh Mohata on 29/09/24.
//

import UIKit

final class AboutViewItemCell: UICollectionViewCell {
    static let identifier: String = String(describing: AboutViewItemCell.self)
    
    // MARK: UI Elements
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 0
        return stack
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .heavy)
        return label
    }()
    
    private var borderLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var isCurrent: Bool = false
    
    private var selectedTextColor: UIColor {
        isCurrent ? .projectPink : .gray112
    }
    
    private var selectedBackgroundColor: UIColor {
        isCurrent ? .projectPink : .clear
    }
    
    private var onClick: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(borderLine)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            borderLine.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapView)))
    }
    
    func configure(with title: String, isSelected: Bool, onClick: (() -> Void)?) {
        self.onClick = onClick
        
        label.text = title
        isCurrent = isSelected
        
        label.textColor = selectedTextColor
        borderLine.backgroundColor = selectedBackgroundColor
    }
    
    @objc
    private func onTapView() {
        onClick?()
    }
}
