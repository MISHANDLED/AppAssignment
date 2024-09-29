//
//  MovieDetailsContracts.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import Foundation

// One way communication from presenter to view
protocol MDPresenterViewProtocol: AnyObject {
    func dataFetched(images: [String], details: DetailsView.ViewModel, bookingDetails: BookingsView.ViewModel, aboutDetails: [AboutView.ViewModel])
    func updateTimer(days: Int, hours: Int, minutes: Int, seconds: Int)
}

// One way communication from view to presenter
protocol MDViewPresenterProtocol: AnyObject {
    func fetchData()
}

// One way communication from presenter to interactor
protocol MDPresenterInteractorProtocol: AnyObject {
    func fetchData()
    func updateTimer(to targetDate: Date)
}

// One way communication from interactor to presenter
protocol MDInteractorPresenterProtocol: AnyObject {
    func dataFetched(data: MovieDetailEntity)
    func updateTimer(days: Int, hours: Int, minutes: Int, seconds: Int)
}

// One way communication from presenter to router
protocol MDPresenterRouterProtocol: AnyObject {
    
}
