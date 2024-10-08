//
//  MovieDetailEntity.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import Foundation

struct MovieDetailEntity {
    let images: [String]
    
    let title: String
    let tag: String
    let description: String
    let location: String
    let date: Date
    
    let bookingCloseDate: Date
    let bookingUserCount: Int
    
    let userAvatars: [String]
    
    let content: [AboutMovieSection]
}

struct AboutMovieSection {
    let title: String
    let content: String
}
