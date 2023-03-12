//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by S.M on 3/2/23.
//

import SwiftUI

extension Color {
    static let llGreen = Color(red: 73 / 255, green: 94 / 255, blue: 87 / 255)
    static let llYellow = Color(red: 244 / 255, green: 206 / 255, blue: 20 / 255)
    static let llGray = Color(red: 237 / 255, green: 239 / 255, blue: 238 / 255)
}

@main
struct Little_LemonApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Onboarding()
               .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
