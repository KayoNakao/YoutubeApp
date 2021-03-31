//
//  Date.swift
//  YoutubeApp
//
//  Created by Raphael Souza on 2020-04-02.
//  Copyright © 2020 Guarana Technologies Inc. All rights reserved.
//

import Foundation

enum DateFormat {
    case monthDay
    case hoursMinutes
    case custom(String)
    
    var value: String {
        switch self {
        case .hoursMinutes: return "h.mm"
        case .monthDay: return "MMM, dd"
        case .custom(let pattern): return pattern
        }
    }
}

extension Date {
    func isAfter(_ date: Date) -> Bool {
        return self.timeIntervalSince1970 > date.timeIntervalSince1970
    }
    
    func stringDate(as format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.value
        return dateFormatter.string(from: self)
    }
}
