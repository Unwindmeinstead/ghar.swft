//
//  Models.swift
//  Home
//
//  Created by UNKNOWN on 3/31/25.
//

import Foundation
import SwiftUI

// Navigation menu items
enum NavigationItem: String, Identifiable, CaseIterable {
    case dashboard = "Dashboard"
    case bills = "Bills"
    case vehicles = "Vehicles"
    case passwords = "Passwords"
    case subscriptions = "Subscriptions"
    case insurances = "Insurances"
    case benefits = "Benefits"
    case finances = "Finances"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .dashboard: return "square.grid.2x2"
        case .bills: return "doc.text"
        case .vehicles: return "car"
        case .passwords: return "lock.shield"
        case .subscriptions: return "repeat.circle"
        case .insurances: return "umbrella"
        case .benefits: return "gift"
        case .finances: return "dollarsign.circle"
        }
    }
}

// Sample data models for our app
struct Bill: Identifiable {
    var id = UUID()
    var name: String
    var amount: Double
    var dueDate: Date
    var isPaid: Bool = false
}

struct Vehicle: Identifiable {
    var id = UUID()
    var name: String
    var model: String
    var year: Int
    var licensePlate: String
}

struct Subscription: Identifiable {
    var id = UUID()
    var name: String
    var cost: Double
    var billingCycle: BillingCycle
    var nextBillingDate: Date
}

enum BillingCycle: String, CaseIterable {
    case monthly = "Monthly"
    case quarterly = "Quarterly"
    case yearly = "Yearly"
}

// Sample data for dashboard widgets
class SampleData {
    static let upcomingBills = [
        Bill(name: "Electricity", amount: 145.50, dueDate: Date().addingTimeInterval(86400 * 3)),
        Bill(name: "Internet", amount: 89.99, dueDate: Date().addingTimeInterval(86400 * 5)),
        Bill(name: "Water", amount: 65.25, dueDate: Date().addingTimeInterval(86400 * 10))
    ]
    
    static let subscriptions = [
        Subscription(name: "Netflix", cost: 14.99, billingCycle: .monthly, nextBillingDate: Date().addingTimeInterval(86400 * 15)),
        Subscription(name: "Spotify", cost: 9.99, billingCycle: .monthly, nextBillingDate: Date().addingTimeInterval(86400 * 7)),
        Subscription(name: "iCloud+", cost: 2.99, billingCycle: .monthly, nextBillingDate: Date().addingTimeInterval(86400 * 20))
    ]
} 