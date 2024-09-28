//
//  MovieDetailViewController.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    // MARK: UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let imageCarousel: ImageCarouselView = {
        let carousel = ImageCarouselView(frame: .zero)
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()
    
    private let detailsView: DetailsView = {
        let view = DetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let bookingDetailsView: BookingsView = {
        let view = BookingsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: Data Variables
    var presenter: MDViewPresenterProtocol
    
    
    // MARK: init
    init(presenter: MDViewPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(imageCarousel)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageCarousel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageCarousel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageCarousel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            scrollView.topAnchor.constraint(equalTo: imageCarousel.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1)
        ])
        
        let stackHeight = stackView.heightAnchor.constraint(equalToConstant: 100)
        stackHeight.priority = .defaultLow
        stackHeight.isActive = true
        
        stackView.addArrangedSubview(detailsView)
        stackView.addArrangedSubview(bookingDetailsView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        presenter.fetchData()
    }
}


// MARK: MDPresenterViewProtocol
extension MovieDetailViewController: MDPresenterViewProtocol {
    func dataFetched(images: [String], details: DetailsView.ViewModel, bookingDetails: BookingsView.ViewModel) {
        imageCarousel.configure(with: images)
        detailsView.configure(with: details)
        bookingDetailsView.configure(with: bookingDetails)
    }
    
    func updateTimer(days: Int, hours: Int, minutes: Int, seconds: Int) {
        bookingDetailsView.configure(days: days, hours: hours, minutes: minutes, seconds: seconds)
    }
}
