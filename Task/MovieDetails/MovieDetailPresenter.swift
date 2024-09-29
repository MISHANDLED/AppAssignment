//
//  MovieDetailPresenter.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import Foundation

final class MovieDetailPresenter {
    weak var view: MDPresenterViewProtocol?
    var interactor: MDPresenterInteractorProtocol
    var router: MDPresenterRouterProtocol
    
    init(interactor: MDPresenterInteractorProtocol, router: MDPresenterRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: MDViewPresenterProtocol
extension MovieDetailPresenter: MDViewPresenterProtocol {
    func fetchData() {
        interactor.fetchData()
    }
}

// MARK: MDInteractorPresenterProtocol
extension MovieDetailPresenter: MDInteractorPresenterProtocol {
    func updateTimer(days: Int, hours: Int, minutes: Int, seconds: Int) {
        view?.updateTimer(days: days, hours: hours, minutes: minutes, seconds: seconds)
    }
    
    func dataFetched(data: MovieDetailEntity) {
        let movieDetails = convertToDetailsModel(from: data)
        let bookingDetails = convertToBookingModel(from: data)
        let aboutDetails = convertToAboutModel(from: data)
        
        interactor.updateTimer(to: data.bookingCloseDate)
        
        view?.dataFetched(
            images: data.images,
            details: movieDetails,
            bookingDetails: bookingDetails,
            aboutDetails: aboutDetails
        )
    }
}


// MARK: Converters
extension MovieDetailPresenter {
    private func convertToDetailsModel(from data: MovieDetailEntity) -> DetailsView.ViewModel {
        .init(
            title: data.title,
            tag: data.tag,
            description: data.description,
            location: data.location,
            showtime: data.date.formatted(as: .timeWithDay)
        )
    }
    
    private func convertToBookingModel(from data: MovieDetailEntity) -> BookingsView.ViewModel {
        .init(
            avatars: data.userAvatars,
            userCount: data.bookingUserCount
        )
    }
    
    private func convertToAboutModel(from data: MovieDetailEntity) -> [AboutView.ViewModel] {
        data.content.enumerated().map { index, content in
                .init(
                    title: content.title,
                    content: content.content,
                    isSelected: index == 0
                )
        }
    }
}
