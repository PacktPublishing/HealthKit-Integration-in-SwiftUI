//
//  MetricCardView.swift
//  HealthkitinSwiftUI
//
//  Created by DevTechie on 1/23/25.
//
import Charts
import SwiftUI

struct MetricCardView: View {
    @StateObject private var healthKit = HealthKitManager.shared
    let metric: HealthMetric
    
    var weeklyTotal: Double {
        healthKit.healthData[metric]?.reduce(0) { $0 + $1.value } ?? 0
    }
    
    var weeklyAvg: Double {
        (healthKit.healthData[metric]?.reduce(0) { $0 + $1.value } ?? 0) / 8.0
    }
    
    var dateRange: String {
        guard let records = healthKit.healthData[metric],
              let firstDate = records.first?.date,
              let lastDate = records.last?.date else { return "No data" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        
        return "\(dateFormatter.string(from: firstDate)) - \(dateFormatter.string(from: lastDate))"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: metric.systemImage)
                Text(metric.rawValue)
                    .font(.headline)
            }
            .foregroundStyle(metric.color.gradient)
            
            HStack(alignment: .lastTextBaseline) {
                Text("\(Int(weeklyTotal))")
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
                
                Text("Average \(Int(weeklyAvg))")
                    .font(.caption)
                    .foregroundStyle(.primary)
            }
            
            HStack {
                Text(metric.unit)
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Text(dateRange)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Chart(healthKit.healthData[metric] ?? []) { record in
                LineMark(
                    x: .value("Date", record.date, unit: .day),
                    y: .value("Value", record.value)
                )
                .foregroundStyle(metric.color.gradient)
            }
            .frame(height: 60)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.card.gradient)
                .shadow(color: Color.cardShadow, radius: 2)
        }
    }
}
