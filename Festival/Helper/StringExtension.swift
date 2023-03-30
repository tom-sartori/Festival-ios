//
// Created by Tom Sartori on 3/29/23.
//

import Foundation

extension String {

    func toISODate() -> Date? {
        let formatter = ISO8601DateFormatter()
        // Insert .withFractionalSeconds to the current format.
        formatter.formatOptions.insert(.withFractionalSeconds)
        return formatter.date(from: self)
    }
}
