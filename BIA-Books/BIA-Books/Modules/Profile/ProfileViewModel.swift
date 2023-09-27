//
//  ViewModel.swift
//  DiplomaLibraryOrig
//
//  Created by Dmitry Apenko on 20.02.2023.
//

import Foundation
import UIKit

class ProfileViewModel {
    private let dataFetcher = NetworkDataFetcher(networking: NetworkService())
    var dataSource: Dynamic<Profile?> = Dynamic(nil)
    
    func getUserData() {
        dataFetcher.getUserInfo { [weak self] userInfo in
            var userPhoto: UIImage? = nil
            if userPhoto == nil {
                userPhoto = UIImage(named: "2")
            }
            
            guard let userInfo else { return }
            let domainUserInfo = Profile(profilePhoto: userPhoto, name: userInfo.firstName, secondName: userInfo.lastName, mail: userInfo.email)
            
            self?.dataSource.value = domainUserInfo
        }
    }
}
