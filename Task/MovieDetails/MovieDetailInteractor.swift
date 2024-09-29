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
            tag: "Blockbuster",
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
            ],
            
            content: generateAboutSection()
        )
        return entity
    }()
    
    private func generateAboutSection() -> [AboutMovieSection] {
        let aboutSection = AboutMovieSection(
            title: "About",
            content: """
            Mad Max: Fury Road is a 2015 post-apocalyptic action film directed by George Miller. The film is the fourth installment in the Mad Max franchise and stars Tom Hardy as Max Rockatansky, alongside Charlize Theron as Imperator Furiosa. Set in a desert wasteland where water and fuel are scarce commodities, the story follows Max and Furiosa as they escape from the tyrannical Immortan Joe with his five wives.
            
            Release Date: May 15, 2015
            Genre: Action, Adventure, Sci-Fi
            Duration: 120 minutes
            """
        )
        
        let castSection = AboutMovieSection(
            title: "Cast",
            content: """
            - Tom Hardy as Max Rockatansky
            - Charlize Theron as Imperator Furiosa
            - Nicholas Hoult as Nux
            - Hugh Keays-Byrne as Immortan Joe
            - Rosie Huntington-Whiteley as The Splendid Angharad
            - Riley Keough as Capable
            - Zoë Kravitz as Toast the Knowing
            - Abbey Lee as The Dag
            - Nathan Jones as Rictus Erectus
            """
        )
        
        let timingsSection = AboutMovieSection(
            title: "Timings",
            content: """
            - Monday, Oct 2: 12:00 PM, 3:30 PM, 7:00 PM
            - Tuesday, Oct 3: 1:00 PM, 4:00 PM, 8:00 PM
            - Wednesday, Oct 4: 12:00 PM, 3:30 PM, 6:00 PM
            - Thursday, Oct 5: 11:00 AM, 2:30 PM, 7:00 PM
            - Friday, Oct 6: 12:00 PM, 4:00 PM, 8:00 PM
            """
        )
        
        let locationsSection = AboutMovieSection(
            title: "Locations",
            content: """
            - AMC Metreon 16, San Francisco, CA
            - Regal LA Live, Los Angeles, CA
            - Alamo Drafthouse Cinema, Austin, TX
            - Cinepolis Luxury Cinemas, New York, NY
            - Odeon Leicester Square, London, UK
            """
        )
        
        let productionSection = AboutMovieSection(
            title: "Production",
            content: """
            - Director: George Miller
            - Producers: Doug Mitchell, George Miller, P.J. Voeten
            - Writers: George Miller, Brendan McCarthy, Nico Lathouris
            - Cinematographer: John Seale
            - Editor: Margaret Sixel
            - Music: Junkie XL
            - Production Companies: Warner Bros. Pictures, Village Roadshow Pictures, Kennedy Miller Mitchell
            - Budget: $150 million
            - Box Office: $374.7 million (worldwide)
            """
        )
        
        let reviewsSection = AboutMovieSection(
            title: "Reviews",
            content: """
            - The Guardian: "A surreal and spectacular post-apocalyptic adventure that sets the bar for action cinema." - ★★★★★
            - Rotten Tomatoes: 97% (Certified Fresh)
            - IMDB: 8.1/10
            - Roger Ebert: "An explosive visual masterpiece that keeps you on the edge of your seat from start to finish." - ★★★★½
            - New York Times: "A thrilling spectacle of non-stop action and impressive world-building."
            """
        )
        
        let moreSection = AboutMovieSection(
            title: "More",
            content: """
            - Academy Awards: Won 6 Oscars including Best Editing, Best Costume Design, Best Production Design, Best Sound Mixing, Best Sound Editing, Best Makeup and Hairstyling.
            - Fun Facts:
                - The film was shot primarily in Namibia, which provided the desert wasteland look.
                - Charlize Theron shaved her head for the role of Furiosa and wore a wig for her next film.
                - The film's action sequences were praised for their use of practical effects, including real explosions and car stunts.
                - George Miller first conceived of Fury Road in 1998, but it took over a decade to begin production.
            """
        )
        
        return [aboutSection, castSection, timingsSection, locationsSection, productionSection, reviewsSection, moreSection]
    }
    
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
