//
//  IOSTakeHomeApp.swift
//  IOSTakeHome
//
//  Created by lapshop on 5/11/23.
//

import SwiftUI

@main
struct IOSTakeHomeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                PeopleView()
                    .tabItem {
                        Symbols.person
                        Text("Home")
                    }
                
                SettingView()
                    .tabItem {
                        Symbols.gear
                        Text("Settigns")
                    }
                
            }
        }
    }
}
