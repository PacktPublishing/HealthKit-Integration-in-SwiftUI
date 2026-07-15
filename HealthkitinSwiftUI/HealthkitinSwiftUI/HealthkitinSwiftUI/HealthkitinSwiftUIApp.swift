//
//  HealthkitinSwiftUIApp.swift
//  HealthkitinSwiftUI
//
//  Created by DevTechie on 1/23/25.
//

import SwiftUI

@main
struct HealthkitinSwiftUIApp: App {
    @StateObject private var healthKit = HealthKitManager.shared
    
    var body: some Scene {
        WindowGroup {
            if !healthKit.isAuthorized {
                PermissionsView()
            } else {
                ContentView()
            }
        }
    }
}
