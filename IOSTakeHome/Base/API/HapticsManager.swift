//
//  HapticsManager.swift
//  IOSTakeHome
//
//  Created by lapshop on 5/15/23.
//


import Foundation
import UIKit

enum UserDefaultKeys {
    static let hapticsEnabled = "hapticsEnabled"
}

fileprivate final class HapticsManager {
    
    static let shared = HapticsManager()
    
    private let feedback = UINotificationFeedbackGenerator()
    
    private init() {}
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        feedback.notificationOccurred(notification)
    }
}

func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: UserDefaultKeys.hapticsEnabled) {
        HapticsManager.shared.trigger(notification)
    }
}

