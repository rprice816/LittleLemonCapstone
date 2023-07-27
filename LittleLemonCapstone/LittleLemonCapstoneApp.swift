//
//  LittleLemonCapstoneApp.swift
//  LittleLemonCapstone
//
//  Created by russell price on 7/22/23.
//

import SwiftUI

@main
struct LittleLemonCapstoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
