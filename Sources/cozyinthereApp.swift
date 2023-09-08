//
//  cozyinthereApp.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/08/19.
//

import SwiftUI

@main
struct cozyinthereApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            MainView(store: .init(initialState: Main.State(), reducer: {
                Main()
            }))
        }
    }
}
