//
//  ProfileViewModel.swift
//  SocialCademy
//
//  Created by Michał Gerlach on 23/11/2022.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject, StateManager {
    // ----------- Variables -----------
    @Published var name: String
    @Published var imageURL: URL? {
        didSet {
            imageURLDidChange(from: oldValue)
        }
    }
    @Published var error: Error?
    @Published var isWorking = false
    
    private let authService: AuthService
    
    init(user: User, authService: AuthService) {
        self.name = user.name
        self.imageURL = user.imageURL
        self.authService = authService
    }
    
    func signOut() {
        withStateManagingTask(perform: authService.signOut)
    }
    
    private func imageURLDidChange(from oldValue: URL?) {
        guard imageURL != oldValue else { return }
        withStateManagingTask { [self] in
            try await authService.updateProfilePicture(to: imageURL)
        }
    }
}
