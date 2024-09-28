//
//  ImageCarouselCell.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import SDWebImage
import UIKit

final class ImageCarouselCell: UICollectionViewCell {
    static let identifier: String = String(describing: ImageCarouselCell.self)
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupViews() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
    }
    
    func configure(with image: String) {
        imageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(systemName: "photo.fill"))
    }
}
