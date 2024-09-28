//
//  UserImageView.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import SDWebImage
import UIKit

final class UserImageView: UIView {
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        backgroundColor = .white
    }
    
    func configure(with url: String) {
        imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(systemName: "person"))
    }
}
