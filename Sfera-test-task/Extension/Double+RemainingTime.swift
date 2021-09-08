//
//  Double+RemainingTime.swift
//  Sfera-test-task
//
//  Created by Marcos Vicente on 08.09.2021.
//

import Foundation

extension Double {
    func formattedRemainingTime() -> String {
        let duration = TimeInterval(self)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = [ .pad ]
        return formatter.string(from: duration) ?? ""
    }
}
