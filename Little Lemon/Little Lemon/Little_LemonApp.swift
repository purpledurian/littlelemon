//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by S.M on 3/2/23.
//

import SwiftUI

@main
struct Little_LemonApp: App {
    var body: some Scene {
        WindowGroup {
            Onboarding()
               // .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
