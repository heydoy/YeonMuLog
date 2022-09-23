//
//  OnboardingMessage.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/09/23.
//

import Foundation

struct OnboardingMessage {
    let imageName: String
    let title: String
    let subtitle: String
}

extension OnboardingMessage {
    static let messages: [OnboardingMessage] = [
        OnboardingMessage(imageName: "onboarding-1",
                          title: "FirstOnboardingTitle".localized,
                          subtitle: "FirstOnboardingSubtitle".localized),
        OnboardingMessage(imageName: "onboarding-2",
                          title: "SecondOnboardingTitle".localized,
                          subtitle: "SecondOnboardingSubtitle".localized),
        OnboardingMessage(imageName: "onboarding-3",
                          title: "ThirdOnboardingTitle".localized,
                          subtitle: "ThirdOnboardingSubtitle".localized),
    ]
    
}
