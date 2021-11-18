//
//  Shower_AppApp.swift
//  Shower App
//
//  Created by Student on 11/11/21.
//

import SwiftUI

@main
struct Shower_AppApp: App {
    @ObservedObject var timeData = TimeData()
    @Environment(\.scenePhase) var scenePhase
       
    var body: some Scene {
        WindowGroup {
            ContentView(times: $timeData.times)
                .onAppear {
                    timeData.load()
                }
        }
        .onChange(of: scenePhase) { phase in
                            if phase == .inactive {
                                timeData.save()
                            }
                        }
    }
}
