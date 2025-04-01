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
    var isRecurring: Bool = false
    var category: BillCategory = .utilities
    var isPaid: Bool = false
    
    // Bill categories enum
    enum BillCategory: String, CaseIterable, Identifiable {
        case utilities = "Utilities"
        case housing = "Housing"
        case transportation = "Transportation"
        case insurance = "Insurance"
        case entertainment = "Entertainment"
        case other = "Other"
        
        var id: String { self.rawValue }
        
        var icon: String {
            switch self {
            case .utilities: return "bolt.fill"
            case .housing: return "house.fill"
            case .transportation: return "car.fill"
            case .insurance: return "shield.fill"
            case .entertainment: return "tv.fill"
            case .other: return "doc.fill"
            }
        }
    }
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
        Bill(name: "Electricity", amount: 145.50, dueDate: Date().addingTimeInterval(86400 * 3), isRecurring: true, category: .utilities),
        Bill(name: "Internet", amount: 89.99, dueDate: Date().addingTimeInterval(86400 * 5), isRecurring: true, category: .utilities),
        Bill(name: "Water", amount: 65.25, dueDate: Date().addingTimeInterval(86400 * 10), isRecurring: true, category: .utilities)
    ]
    
    static let subscriptions = [
        Subscription(name: "Netflix", cost: 14.99, billingCycle: .monthly, nextBillingDate: Date().addingTimeInterval(86400 * 15)),
        Subscription(name: "Spotify", cost: 9.99, billingCycle: .monthly, nextBillingDate: Date().addingTimeInterval(86400 * 7)),
        Subscription(name: "iCloud+", cost: 2.99, billingCycle: .monthly, nextBillingDate: Date().addingTimeInterval(86400 * 20))
    ]
} 