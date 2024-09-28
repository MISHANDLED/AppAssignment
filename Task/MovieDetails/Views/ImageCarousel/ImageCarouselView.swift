//
//  ImageCarouselView.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import UIKit

final class ImageCarouselView: UIView {
    // MARK: UI Elements
    private let stack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = .zero
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .gray217
        pageControl.currentPageIndicatorTintColor = .projectPink
        pageControl.isEnabled = false
        return pageControl
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ImageCarouselCell.self, forCellWithReuseIdentifier: ImageCarouselCell.identifier)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.isPagingEnabled = true
        
        return collection
    }()
    
    
    // MARK: Data Variables
    var elements: [String] = []
    
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupViews() {
        addSubview(stack)
        
        stack.addArrangedSubview(collectionView)
        stack.addArrangedSubview(pageControl)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 9/16)
        ])
        
        pageControl.numberOfPages = 10
    }
    
    private func setupDataSource() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configure(with images: [String]) {
        elements = images
        pageControl.numberOfPages = elements.count
        pageControl.currentPage = 0
        collectionView.reloadData()
    }
}


// MARK: UICollectionView
extension ImageCarouselView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.identifier, for: indexPath) as? ImageCarouselCell {
            cell.configure(with: elements[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width * 0.9, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.size.width
        let currentPage = Int(collectionView.contentOffset.x / pageWidth)
        
        pageControl.currentPage = currentPage
    }
}
