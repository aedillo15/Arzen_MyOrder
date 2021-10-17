//
//  Arzen_MyOrderApp.swift
//  Arzen_MyOrder
//
//  Created by Arzen Edillo on 2021-10-15.
//

import SwiftUI

@main
struct CoreDataDemoApp: App {
    let persistenceController = PersistenceController.shared
    let coreDBHelper = CoreDBHelper(context: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(coreDBHelper)
        }
    }
}
