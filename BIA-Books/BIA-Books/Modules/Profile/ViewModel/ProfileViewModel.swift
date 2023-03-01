//
//  ViewModel.swift
//  DiplomaLibraryOrig
//
//  Created by Dmitry Apenko on 20.02.2023.
//

import Foundation
import UIKit

class ProfileViewModel {
    private var profile: Profile
    
    var profilePhoto: UIImage {
        return profile.profilePhoto!
    }
    
    var fullName: String {
            return profile.name + " " + profile.secondName
    }
    
    var mail: String {
        return profile.mail
    }
    
    init(profile: Profile) {
        self.profile = profile
    }
}
