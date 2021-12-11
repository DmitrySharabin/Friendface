//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by Dmitry Sharabin on 10.12.2021.
//

import SwiftUI

@main
struct FriendfaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
