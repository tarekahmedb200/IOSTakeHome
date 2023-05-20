//
//  PeopleViewModel.swift
//  IOSTakeHome
//
//  Created by lapshop on 5/13/23.
//

import Foundation

final class PeopleViewModel : ObservableObject {
    
    @Published private(set) var users : [User] = []
    @Published private(set) var error : NetworkingManager.NetworkingError?
    @Published private(set) var isLoading = false
    @Published var hasError = false
    
    
    
    private(set) var page = 1
    private let networkingManager :NetworkingManagerImpl!
    
    
    init(networkingManager : NetworkingManagerImpl = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }
    
    @MainActor
    func fetchUsers() async {
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response =  try await networkingManager.request(session: .shared, endPoint: .people(page: page), type: UsersResponse.self)
            self.users = response.data
        } catch  {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            }else {
                self.error = .custom(error: error)
            }
        }
            
    }
    
    
    @MainActor
    func fetchNextSetofUsers() async {
        page += 1
        
        do {
            let response =  try await networkingManager.request(session: .shared, endPoint: .people(page: page), type: UsersResponse.self)
            self.users += response.data
        } catch  {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            }else {
                self.error = .custom(error: error)
            }
        }
        
        
    }
    
    func hasReachedEnd(of user :User) -> Bool {
        users.last?.id == user.id
    }
    
    
    
}
