//
//  AboutView.swift
//  Task
//
//  Created by Devansh Mohata on 29/09/24.
//

import UIKit

final class AboutView: UIView {
    // MARK: UI Elements
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray112
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.register(AboutViewItemCell.self, forCellWithReuseIdentifier: AboutViewItemCell.identifier)
        return collection
    }()
    
    private let borderLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray230
        return view
    }()
    
    
    // MARK: Data variables
    private var data: [ViewModel] = []
    
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        addSubview(containerView)
        
        containerView.addSubview(collectionView)
        containerView.addSubview(borderLine)
        containerView.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 48),
            
            borderLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            borderLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            borderLine.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            borderLine.heightAnchor.constraint(equalToConstant: 1),
            
            contentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            contentLabel.topAnchor.constraint(equalTo: borderLine.bottomAnchor, constant: 12),
            contentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configure(with data: [ViewModel]) {
        self.data = data
        collectionView.reloadData()
    }
}

extension AboutView {
    struct ViewModel {
        let tagID: UUID = .init()
        let title: String
        let content: String
        var isSelected: Bool
    }
}

extension AboutView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutViewItemCell.identifier, for: indexPath) as? AboutViewItemCell {
            let content = data[indexPath.row]
            cell.configure(with: content.title, isSelected: content.isSelected) { [weak self] in
                self?.updateView(with: content.tagID)
            }
            
            if content.isSelected {
                contentLabel.text = content.content
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = data[indexPath.item].title
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .heavy)]).width + 20
        return CGSize(width: width, height: collectionView.frame.size.height)
    }
    
    func updateView(with id: UUID) {
        for i in 0..<data.count {
            data[i].isSelected = data[i].tagID == id
        }
        
        collectionView.reloadData()
    }
}
