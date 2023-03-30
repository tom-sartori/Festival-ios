//
// Created by Tom Sartori on 3/29/23.
//

import Foundation

extension Date {

    func toISOString() -> String {
        // Create Date Formatter
        let dateFormatter = ISO8601DateFormatter()

        dateFormatter.formatOptions.insert(.withFractionalSeconds)

        // Convert Date to String
        return dateFormatter.string(from: self)
    }

    func toHourMinuteString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
