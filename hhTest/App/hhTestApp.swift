//
//  hhTestApp.swift
//  hhTest
//
//  Created by Валентина Дорина on 13.03.2024.
//

import SwiftUI

@main
struct hhTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(VacancyViewModel())
        }
    }
}
