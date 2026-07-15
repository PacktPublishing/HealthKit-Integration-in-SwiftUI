//
//  HealthRecord.swift
//  HealthkitinSwiftUI
//
//  Created by DevTechie on 1/23/25.
//

import Foundation

struct HealthRecord: Identifiable {
    let id = UUID()
    var date: Date
    var value: Double
}
