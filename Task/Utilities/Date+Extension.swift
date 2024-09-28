//
//  Date+Extension.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import Foundation

enum DateFormatStyle: String {
    case timeWithDay = "h:mm a, d MMMM, EEEE"
}

extension Date {
    func formatted(as format: DateFormatStyle) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}
