//
//  MainTabView.swift
//  SocialCademy
//
//  Created by Michał Gerlach on 22/10/2022.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var factory: ViewModelFactory
    
    var body: some View {
        TabView {
            PostList(viewModel: factory.makePostsViewModel())
                .tabItem {
                    Label("Posts", systemImage: "list.dash")
                }
            PostList(viewModel: factory.makePostsViewModel(filter: .favorites))
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(ViewModelFactory.preview)
    }
}
