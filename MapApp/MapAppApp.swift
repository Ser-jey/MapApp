//
//  MapAppApp.swift
//  MapApp
//
//  Created by Сергей Кривошеев on 26.08.2022.
//

import SwiftUI

@main
struct MapAppApp: App {
    @StateObject var vm = LocationsViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
