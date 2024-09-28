//
//  MovieDetailInteractor.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import Foundation

final class MovieDetailInteractor {
    weak var presenter: MDInteractorPresenterProtocol?
    
    private var timer: Timer?
    
    private lazy var movieDetail: MovieDetailEntity = {
        let today = Date()
        let oneDayInSeconds: TimeInterval = 1 * 24 * 60 * 60
        
        let entity = MovieDetailEntity(
            images: [
                "https://i.imgur.com/CzXTtJV.jpg",
                "https://i.imgur.com/OB0y6MR.jpg",
                "https://i.imgur.com/OnwEDW3.jpg"
            ],
            title: "Mad Max saga: Fury Road",
            description: "When the world is taken by darkness, a hero will rise.",
            location: "Cinephile, Bangalore",
            date: today.addingTimeInterval(oneDayInSeconds),
            
            bookingCloseDate: today.addingTimeInterval(2 * oneDayInSeconds),
            
            bookingUserCount: 10_001,
            
            userAvatars: [
                "https://cdn.jsdelivr.net/gh/alohe/avatars/png/vibrent_1.png",
                "https://cdn.jsdelivr.net/gh/alohe/avatars/png/vibrent_2.png",
                "https://cdn.jsdelivr.net/gh/alohe/avatars/png/vibrent_3.png",
                "https://cdn.jsdelivr.net/gh/alohe/avatars/png/vibrent_4.png",
                "https://cdn.jsdelivr.net/gh/alohe/avatars/png/vibrent_5.png"
            ]
        )
        return entity
    }()
    
    private func calculateRemainingTime(to targetDate: Date) {
        let currentDate = Date()
        let calendar = Calendar.current
        
        // If the target date has passed
        if targetDate <= currentDate {
            timer?.invalidate()
            presenter?.updateTimer(days: .zero, hours: .zero, minutes: .zero, seconds: .zero)
            return
        }
        
        let components: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = calendar.dateComponents(components, from: currentDate, to: targetDate)
        
        let timeRemaining = (
            days: difference.day ?? 0,
            hours: difference.hour ?? 0,
            minutes: difference.minute ?? 0,
            seconds: difference.second ?? 0
        )
        
        presenter?.updateTimer(
            days: timeRemaining.days,
            hours: timeRemaining.hours,
            minutes: timeRemaining.minutes,
            seconds: timeRemaining.seconds
        )
    }
}

// MARK: MDPresenterInteractorProtocol
extension MovieDetailInteractor: MDPresenterInteractorProtocol {
    func fetchData() {
        presenter?.dataFetched(data: movieDetail)
    }
    
    func updateTimer(to targetDate: Date) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.calculateRemainingTime(to: targetDate)
        }
    }
}
