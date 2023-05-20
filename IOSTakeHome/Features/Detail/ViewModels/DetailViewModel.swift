//
//  DetailViewModel.swift
//  IOSTakeHome
//
//  Created by lapshop on 5/13/23.
//

import Foundation

final class DetailViewModel : ObservableObject {
    
    @Published private(set) var userInfo : UserDetailResponse?
    @Published private(set) var error : NetworkingManager.NetworkingError?
    @Published var hasError = false
    
    @MainActor
    func fetchDetails(for id:Int) async {
        
        
        do {
            let response =  try await NetworkingManager.shared.request(endPoint: .detail(id: id), type: UserDetailResponse.self)
            self.userInfo = response
        } catch  {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            }else {
                self.error = .custom(error: error)
            }
        }
    }
}
