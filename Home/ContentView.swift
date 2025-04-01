//
//  ContentView.swift
//  Home
//
//  Created by UNKNOWN on 3/31/25.
//

import SwiftUI

// MARK: - Import Models to access Bill structure
import Foundation

// Add TimeFrame enum at the top, after NavigationItem declaration
enum TimeFrame: String, CaseIterable, Identifiable {
    case week = "Week"
    case month = "Month"
    case quarter = "Quarter"
    case year = "Year"
    
            case .transportation: return "car.fill"
            case .insurance: return "shield.fill"
            case .entertainment: return "tv.fill"
            case .other: return "doc.fill"
            }
        }
    }
}

struct ContentView: View {
    @State private var selectedNavItem: NavigationItem? = .dashboard
    @State private var isSearching = false
    @State private var searchText = ""
    @State private var showAddActionSheet = false
    
    var body: some View {
        ZStack {
            NavigationSplitView {
                // Sidebar
                SidebarView(selectedNavItem: $selectedNavItem)
                    .navigationSplitViewColumnWidth(min: 250, ideal: 270)
            } detail: {
                // Initial content view
                if let item = selectedNavItem {
                    destinationView(for: item)
                } else {
                    DashboardView()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigation) {
                    Button(action: toggleSidebar) {
                        Image(systemName: "sidebar.left")
                            .foregroundColor(GharTheme.accent)
                    }
                }
                
                ToolbarItemGroup(placement: .primaryAction) {
                    Button(action: { isSearching.toggle() }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(GharTheme.accent)
                    }
                }
            }
            .searchable(text: $searchText, isPresented: $isSearching)
            .navigationTitle(selectedNavItem?.rawValue ?? "Dashboard")
            
            // Floating action button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { showAddActionSheet = true }) {
                        Image(systemName: "plus")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Circle().fill(GharTheme.accent))
                            .shadow(color: GharTheme.accent.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(24)
                }
            }
        }
        .confirmationDialog("Add New Item", isPresented: $showAddActionSheet, titleVisibility: .visible) {
            Button("Add Bill") {
                // Action to add a new bill
            }
            
            Button("Add Subscription") {
                // Action to add a new subscription
            }
            
            Button("Add Task") {
                // Action to add a new task
            }
            
            Button("Add Vehicle") {
                // Action to add a new vehicle
            }
            
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Choose an item to add")
        }
    }
    
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    
    @ViewBuilder
    func destinationView(for item: NavigationItem) -> some View {
        switch item {
        case .dashboard:
            DashboardView()
        case .bills:
            BillsView()
        case .vehicles:
            VehiclesView()
        case .passwords:
            PasswordsView()
        case .subscriptions:
            SubscriptionsView()
        case .insurances:
            InsurancesView()
        case .benefits:
            BenefitsView()
        case .finances:
            FinancesView()
        }
    }
}

// MARK: - Sidebar View
struct SidebarView: View {
    @Binding var selectedNavItem: NavigationItem?
    @State private var showSettingsSheet = false
    @State private var showProfileSheet = false
    
    var body: some View {
        List(selection: $selectedNavItem) {
            // App title and logo
            HStack {
                Image(systemName: "house.fill")
                    .imageScale(.large)
                    .font(.system(size: 22))
                    .foregroundColor(GharTheme.accent)
                Text("Ghar")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(GharTheme.primaryText)
            }
            .padding(.vertical, 12)
            .padding(.bottom, 8)
            
            Divider()
                .padding(.vertical, 8)
            
            // Navigation items
            ForEach(NavigationItem.allCases) { item in
                NavigationLink(value: item) {
                    HStack(spacing: 12) {
                        Image(systemName: item.icon)
                            .font(.system(size: 18))
                            .frame(width: 26)
                            .foregroundColor(selectedNavItem == item ? GharTheme.accent : GharTheme.textSecondary)
                        Text(item.rawValue)
                            .font(.title3)
                            .foregroundColor(selectedNavItem == item ? GharTheme.textPrimary : GharTheme.textSecondary)
                    }
                    .padding(.vertical, 8)
                }
                .tag(item)
            }
            
            Spacer()
                .frame(height: 30)
                
            Divider()
                .padding(.vertical, 8)
            
            // Settings and profile buttons at bottom of sidebar
            Group {
                Button(action: { showProfileSheet.toggle() }) {
                    HStack(spacing: 12) {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 18))
                            .frame(width: 26)
                            .foregroundColor(GharTheme.textSecondary)
                        Text("Profile")
                            .font(.title3)
                            .foregroundColor(GharTheme.textSecondary)
                    }
                    .padding(.vertical, 8)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.vertical, 4)
                .sheet(isPresented: $showProfileSheet) {
                    VStack {
                        Text("Profile Settings")
                            .font(.title)
                            .foregroundColor(GharTheme.textPrimary)
                        
                        Text("Profile settings coming soon")
                            .foregroundColor(GharTheme.textSecondary)
                            .padding()
                        
                        Button("Close") {
                            showProfileSheet = false
                        }
                        .padding()
                    }
                    .frame(width: 400, height: 300)
                    .padding()
                }
                
                Button(action: { showSettingsSheet.toggle() }) {
                    HStack(spacing: 12) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 18))
                            .frame(width: 26)
                            .foregroundColor(GharTheme.textSecondary)
                        Text("Settings")
                            .font(.title3)
                            .foregroundColor(GharTheme.textSecondary)
                    }
                    .padding(.vertical, 8)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.vertical, 4)
                .sheet(isPresented: $showSettingsSheet) {
                    VStack {
                        Text("App Settings")
                            .font(.title)
                            .foregroundColor(GharTheme.textPrimary)
                        
                        Text("Settings coming soon")
                            .foregroundColor(GharTheme.textSecondary)
                            .padding()
                        
                        Button("Close") {
                            showSettingsSheet = false
                        }
                        .padding()
                    }
                    .frame(width: 400, height: 300)
                    .padding()
                }
            }
        }
        .listStyle(SidebarListStyle())
        .onAppear {
            if selectedNavItem == nil {
                selectedNavItem = .dashboard
            }
        }
    }
}

// MARK: - Vehicles View
struct VehiclesView: View {
    @State private var selectedVehicle: Vehicle? = nil
    @State private var searchQuery = ""
    @State private var isAddingVehicle = false
    @State private var showingMileageEntry = false
    
    // Sample vehicles data
    private let vehicles = [
        Vehicle(name: "Family SUV", model: "Toyota RAV4", year: 2021, licensePlate: "ABC-1234"),
        Vehicle(name: "Work Sedan", model: "Honda Accord", year: 2019, licensePlate: "XYZ-5678")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Enhanced header with search and add button
            HStack {
                Text("Your Vehicles")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(GharTheme.textPrimary)
                
                Spacer()
                
                // Search field
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(GharTheme.textSecondary)
                    
                    TextField("Search vehicles...", text: $searchQuery)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(8)
                .background(GharTheme.cardBackground)
                .cornerRadius(8)
                .frame(width: 220)
                
                Button(action: { isAddingVehicle = true }) {
                    Label("Add Vehicle", systemImage: "plus")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(GharTheme.accent)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            
            // Quick stats overview
            HStack(spacing: 20) {
                VehicleStatCard(title: "Total Vehicles", value: "\(vehicles.count)", icon: "car.2.fill", color: .blue)
                VehicleStatCard(title: "Due for Service", value: "1", icon: "wrench.fill", color: .orange)
                VehicleStatCard(title: "Upcoming Renewals", value: "None", icon: "calendar.badge.clock", color: .green)
            }
            
            // Enhanced vehicle cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(vehicles) { vehicle in
                        EnhancedVehicleCard(vehicle: vehicle, isSelected: selectedVehicle?.id == vehicle.id)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.3)) {
                                    selectedVehicle = vehicle
                                }
                            }
                    }
                    
                    // Add new vehicle card
                    AddVehicleButton()
                        .onTapGesture {
                            isAddingVehicle = true
                        }
                }
                .padding(.bottom, 8)
            }
            
            if let vehicle = selectedVehicle {
                // Selected vehicle details with enhanced UI
                EnhancedVehicleDetailView(vehicle: vehicle, showMileageEntry: $showingMileageEntry)
            } else {
                // Enhanced prompt to select a vehicle
                VStack {
                    Spacer()
                    
                    Image(systemName: "car.fill")
                        .font(.system(size: 64))
                        .foregroundColor(GharTheme.textSecondary.opacity(0.3))
                        .padding(.bottom, 16)
                    
                    Text("Select a vehicle to view details")
                        .font(.headline)
                        .foregroundColor(GharTheme.textSecondary)
                    
                    Text("Or add a new vehicle to get started")
                        .font(.subheadline)
                        .foregroundColor(GharTheme.textSecondary.opacity(0.7))
                        .padding(.top, 4)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(GharTheme.cardBackground.opacity(0.5))
                .cornerRadius(12)
            }
            
            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(GharTheme.background)
        .sheet(isPresented: $isAddingVehicle) {
            AddVehicleView(isPresented: $isAddingVehicle)
        }
        .sheet(isPresented: $showingMileageEntry) {
            UpdateMileageView(isPresented: $showingMileageEntry, vehicle: selectedVehicle)
        }
    }
}

struct VehicleStatCard: View {
    var title: String
    var value: String
    var icon: String
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
                
                Spacer()
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.callout)
                    .foregroundColor(GharTheme.textSecondary)
                
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(GharTheme.textPrimary)
            }
        }
        .padding(16)
        .frame(height: 120)
        .background(GharTheme.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct EnhancedVehicleCard: View {
    var vehicle: Vehicle
    var isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Enhanced vehicle icon with badge for status
            ZStack(alignment: .topTrailing) {
                Image(systemName: "car.fill")
                    .font(.system(size: 32))
                    .foregroundColor(isSelected ? .white : GharTheme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Status badge - could indicate service due, registration due, etc.
                if vehicle.name == "Family SUV" {
                    ZStack {
                        Circle()
                            .fill(.orange)
                            .frame(width: 20, height: 20)
                        
                        Image(systemName: "wrench.fill")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }
                }
            }
            
            Spacer()
            
            // Vehicle details
            Text(vehicle.name)
                .font(.headline)
                .foregroundColor(isSelected ? .white : GharTheme.textPrimary)
            
            Text("\(vehicle.year) \(vehicle.model)")
                .font(.subheadline)
                .foregroundColor(isSelected ? .white.opacity(0.8) : GharTheme.textSecondary)
            
            // License plate with special styling
            Text(vehicle.licensePlate)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(isSelected ? Color.white.opacity(0.2) : GharTheme.accent.opacity(0.2))
                .foregroundColor(isSelected ? .white : GharTheme.accent)
                .cornerRadius(4)
        }
        .padding(16)
        .frame(width: 180, height: 160)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? GharTheme.accent : GharTheme.cardBackground)
                
                // Add subtle pattern if selected
                if isSelected {
                    Image(systemName: "car.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color.white.opacity(0.05))
                        .offset(x: 40, y: 30)
                }
            }
        )
        .cornerRadius(12)
        .shadow(color: isSelected ? GharTheme.accent.opacity(0.4) : Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.white : Color.clear, lineWidth: 2)
        )
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.spring(response: 0.3), value: isSelected)
    }
}

struct EnhancedVehicleDetailView: View {
    var vehicle: Vehicle
    @Binding var showMileageEntry: Bool
    @State private var activeTab = 0
    
    // Sample service history data
    private let serviceHistory = [
        ServiceRecord(date: Date().addingTimeInterval(-7776000), description: "Oil Change", cost: 49.99, location: "QuickLube"),
        ServiceRecord(date: Date().addingTimeInterval(-15552000), description: "Tire Rotation", cost: 29.99, location: "Discount Tire"),
        ServiceRecord(date: Date().addingTimeInterval(-23328000), description: "Brake Inspection", cost: 75.00, location: "AutoZone")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Enhanced header with more actions
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(vehicle.year) \(vehicle.model)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(GharTheme.textPrimary)
                    
                    Text(vehicle.licensePlate)
                        .font(.subheadline)
                        .foregroundColor(GharTheme.textSecondary)
                }
                
                Spacer()
                
                // Action buttons
                HStack(spacing: 12) {
                    Button(action: { showMileageEntry = true }) {
                        Label("Update Mileage", systemImage: "speedometer")
                            .font(.callout)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(GharTheme.accent.opacity(0.2))
                            .foregroundColor(GharTheme.accent)
                            .cornerRadius(8)
                    }
                    
                    Menu {
                        Button("Add Service Record", action: {})
                        Button("Add Fuel Log", action: {})
                        Button("Edit Vehicle Details", action: {})
                        Divider()
                        Button("Export Records", action: {})
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.system(size: 22))
                            .foregroundColor(GharTheme.textSecondary)
                    }
                }
            }
            
            // Tabs with improved styling
            HStack(spacing: 24) {
                TabButton(title: "Overview", isActive: activeTab == 0) {
                    activeTab = 0
                }
                
                TabButton(title: "Maintenance", isActive: activeTab == 1) {
                    activeTab = 1
                }
                
                TabButton(title: "Documents", isActive: activeTab == 2) {
                    activeTab = 2
                }
                
                TabButton(title: "Insurance", isActive: activeTab == 3) {
                    activeTab = 3
                }
                
                Spacer()
            }
            .padding(.bottom, 10)
            
            // Tab content
            if activeTab == 0 {
                EnhancedVehicleOverviewTab(vehicle: vehicle)
            } else if activeTab == 1 {
                MaintenanceTab(serviceHistory: serviceHistory)
            } else {
                PlaceholderTab(title: ["Documents", "Insurance"][activeTab - 2])
            }
        }
        .padding(24)
        .background(GharTheme.cardBackground)
        .cornerRadius(12)
    }
}

struct EnhancedVehicleOverviewTab: View {
    var vehicle: Vehicle
    
    var body: some View {
        VStack(spacing: 20) {
            // Vehicle stats with enhanced UI
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 20) {
                StatItem(title: "Last Service", value: "3 months ago", icon: "wrench.fill", hasAlert: true)
                StatItem(title: "Mileage", value: "32,450 mi", icon: "speedometer", hasAlert: false)
                StatItem(title: "Fuel Economy", value: "28 mpg", icon: "fuelpump.fill", hasAlert: false)
            }
            
            Divider()
                .padding(.vertical, 10)
            
            // Upcoming events with progress indicators
            VStack(alignment: .leading, spacing: 16) {
                Text("Upcoming Maintenance")
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
                
                EnhancedEventRow(
                    title: "Oil Change",
                    date: "In 2 weeks",
                    icon: "drop.fill",
                    iconColor: .blue,
                    progress: 0.65
                )
                
                EnhancedEventRow(
                    title: "Registration Renewal",
                    date: "In 3 months",
                    icon: "doc.text.fill",
                    iconColor: .green,
                    progress: 0.25
                )
                
                EnhancedEventRow(
                    title: "Tire Rotation",
                    date: "In 4 weeks",
                    icon: "arrow.triangle.2.circlepath",
                    iconColor: .orange,
                    progress: 0.55
                )
            }
            
            Divider()
                .padding(.vertical, 10)
            
            // Fuel history chart
            VStack(alignment: .leading, spacing: 12) {
                Text("Recent Fuel History")
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
                
                HStack(alignment: .bottom, spacing: 8) {
                    ForEach(0..<6) { i in
                        FuelHistoryBar(
                            height: [0.6, 0.8, 0.5, 0.9, 0.7, 0.65][i],
                            label: ["Mar", "Apr", "May", "Jun", "Jul", "Aug"][i]
                        )
                    }
                }
                .frame(height: 120)
                .padding(.top, 8)
            }
        }
    }
}

struct StatItem: View {
    var title: String
    var value: String
    var icon: String
    var hasAlert: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(hasAlert ? .orange : GharTheme.accent)
                
                Text(title)
                    .font(.callout)
                    .foregroundColor(GharTheme.textSecondary)
                
                if hasAlert {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.orange)
                }
            }
            
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(GharTheme.textPrimary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(hasAlert ? Color.orange.opacity(0.1) : GharTheme.background)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(hasAlert ? Color.orange.opacity(0.5) : Color.clear, lineWidth: 1)
        )
    }
}

struct EnhancedEventRow: View {
    var title: String
    var date: String
    var icon: String
    var iconColor: Color
    var progress: Double
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(GharTheme.textPrimary)
                    
                    Spacer()
                    
                    Text(date)
                        .font(.subheadline)
                        .foregroundColor(GharTheme.textSecondary)
                }
                
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: geometry.size.width, height: 6)
                            .opacity(0.2)
                            .foregroundColor(Color.gray)
                        
                        Rectangle()
                            .frame(width: min(CGFloat(self.progress) * geometry.size.width, geometry.size.width), height: 6)
                            .foregroundColor(iconColor)
                    }
                    .cornerRadius(3)
                }
                .frame(height: 6)
            }
            
            Button(action: {}) {
                Text("Details")
                    .font(.callout)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(iconColor.opacity(0.2))
                    .foregroundColor(iconColor)
                    .cornerRadius(6)
            }
        }
        .padding(.vertical, 8)
    }
}

struct FuelHistoryBar: View {
    var height: Double
    var label: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 100)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(GharTheme.accent)
                    .frame(height: CGFloat(height * 100))
            }
            
            Text(label)
                .font(.caption)
                .foregroundColor(GharTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct MaintenanceTab: View {
    var serviceHistory: [ServiceRecord]
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Service History")
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
                
                Spacer()
                
                Button(action: {}) {
                    Label("Add Service", systemImage: "plus")
                        .font(.callout)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(GharTheme.accent.opacity(0.2))
                        .foregroundColor(GharTheme.accent)
                        .cornerRadius(6)
                }
            }
            
            Divider()
            
            // Service history list
            ForEach(serviceHistory) { record in
                ServiceHistoryRow(record: record)
                
                if record.id != serviceHistory.last?.id {
                    Divider()
                }
            }
            
            // Maintenance schedule
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Maintenance Schedule")
                        .font(.headline)
                        .foregroundColor(GharTheme.textPrimary)
                    
                    Spacer()
                    
                    Text("Based on manufacturer recommendations")
                        .font(.caption)
                        .foregroundColor(GharTheme.textSecondary)
                }
                
                Divider()
                
                MaintenanceScheduleItem(service: "Oil Change", interval: "Every 5,000 miles", nextDue: "1,550 miles")
                MaintenanceScheduleItem(service: "Tire Rotation", interval: "Every 7,500 miles", nextDue: "4,050 miles")
                MaintenanceScheduleItem(service: "Air Filter", interval: "Every 15,000 miles", nextDue: "11,550 miles")
                MaintenanceScheduleItem(service: "Brake Fluid", interval: "Every 25,000 miles", nextDue: "21,550 miles")
            }
            .padding(.top, 20)
            .padding(16)
            .background(GharTheme.background.opacity(0.5))
            .cornerRadius(12)
        }
    }
}

struct ServiceRecord: Identifiable {
    let id = UUID()
    let date: Date
    let description: String
    let cost: Double
    let location: String
}

struct ServiceHistoryRow: View {
    var record: ServiceRecord
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Date column
            VStack(alignment: .center, spacing: 4) {
                Text(dateFormatter.string(from: record.date))
                    .font(.callout)
                    .foregroundColor(GharTheme.textPrimary)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 100)
            
            // Separator
            Rectangle()
                .fill(GharTheme.textSecondary.opacity(0.3))
                .frame(width: 1, height: 40)
            
            // Service details
            VStack(alignment: .leading, spacing: 4) {
                Text(record.description)
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
                
                Text("Location: \(record.location)")
                    .font(.caption)
                    .foregroundColor(GharTheme.textSecondary)
            }
            
            Spacer()
            
            // Cost
            Text("$\(String(format: "%.2f", record.cost))")
                .font(.headline)
                .foregroundColor(GharTheme.textPrimary)
        }
        .padding(.vertical, 8)
    }
}

struct MaintenanceScheduleItem: View {
    var service: String
    var interval: String
    var nextDue: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(service)
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
                
                Text(interval)
                    .font(.caption)
                    .foregroundColor(GharTheme.textSecondary)
            }
            
            Spacer()
            
            Text(nextDue)
                .font(.callout)
                .foregroundColor(GharTheme.accent)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(GharTheme.accent.opacity(0.1))
                .cornerRadius(6)
        }
        .padding(.vertical, 8)
    }
}

struct AddVehicleView: View {
    @Binding var isPresented: Bool
    @State private var name = ""
    @State private var model = ""
    @State private var year = ""
    @State private var licensePlate = ""
    @State private var vin = ""
    @State private var currentMileage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Vehicle Information")) {
                    TextField("Nickname (e.g. Family SUV)", text: $name)
                    TextField("Make & Model", text: $model)
                    TextField("Year", text: $year)
                    TextField("License Plate", text: $licensePlate)
                    TextField("VIN (optional)", text: $vin)
                    TextField("Current Mileage", text: $currentMileage)
                }
                
                Section {
                    Button(action: {
                        // Save vehicle
                        isPresented = false
                    }) {
                        Text("Save Vehicle")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .foregroundColor(.white)
                    .listRowBackground(GharTheme.accent)
                    
                    Button(action: { isPresented = false }) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .foregroundColor(GharTheme.textSecondary)
                }
            }
            .navigationTitle("Add New Vehicle")
        }
        .frame(width: 500, height: 500)
    }
}

struct UpdateMileageView: View {
    @Binding var isPresented: Bool
    var vehicle: Vehicle?
    @State private var mileage = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Update Mileage")) {
                    if let vehicle = vehicle {
                        HStack {
                            Text("Vehicle")
                            Spacer()
                            Text("\(vehicle.year) \(vehicle.model)")
                                .foregroundColor(GharTheme.textSecondary)
                        }
                    }
                    
                    TextField("Current Mileage", text: $mileage)
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                
                Section {
                    Button(action: {
                        // Save mileage update
                        isPresented = false
                    }) {
                        Text("Save Mileage")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .foregroundColor(.white)
                    .listRowBackground(GharTheme.accent)
                    
                    Button(action: { isPresented = false }) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .foregroundColor(GharTheme.textSecondary)
                }
            }
            .navigationTitle("Update Mileage")
        }
        .frame(width: 400, height: 300)
    }
}

// MARK: - Passwords View
struct PasswordsView: View {
    @State private var searchText = ""
    @State private var selectedCategory: PasswordCategory = .all
    @State private var showAddPassword = false
    
    enum PasswordCategory: String, CaseIterable, Identifiable {
        case all = "All"
        case websites = "Websites"
        case apps = "Apps"
        case finance = "Finance"
        case work = "Work"
        case personal = "Personal"
        
        var id: String { self.rawValue }
        
        var icon: String {
            switch self {
            case .all: return "tray.fill"
            case .websites: return "globe"
            case .apps: return "app.fill"
            case .finance: return "creditcard.fill"
            case .work: return "briefcase.fill"
            case .personal: return "person.fill"
            }
        }
    }
    
    // Sample password data - changed from private to internal
    struct PasswordItem: Identifiable {
        let id = UUID()
        var title: String
        var username: String
        var category: PasswordCategory
        var lastUpdated: Date
        var strength: PasswordStrength
    }
    
    enum PasswordStrength: String {
        case weak = "Weak"
        case medium = "Medium"
        case strong = "Strong"
        
        var color: Color {
            switch self {
            case .weak: return .red
            case .medium: return .orange
            case .strong: return .green
            }
        }
    }
    
    private let passwords = [
        PasswordItem(title: "Gmail", username: "john.doe", category: .websites, lastUpdated: Date().addingTimeInterval(-86400 * 45), strength: .strong),
        PasswordItem(title: "Amazon", username: "john.doe", category: .websites, lastUpdated: Date().addingTimeInterval(-86400 * 90), strength: .medium),
        PasswordItem(title: "Netflix", username: "john.doe", category: .apps, lastUpdated: Date().addingTimeInterval(-86400 * 10), strength: .strong),
        PasswordItem(title: "Bank of America", username: "john.doe", category: .finance, lastUpdated: Date().addingTimeInterval(-86400 * 120), strength: .strong),
        PasswordItem(title: "Instagram", username: "john.doe", category: .personal, lastUpdated: Date().addingTimeInterval(-86400 * 60), strength: .medium),
        PasswordItem(title: "Slack", username: "john.doe", category: .work, lastUpdated: Date().addingTimeInterval(-86400 * 30), strength: .strong)
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            // Categories sidebar
            VStack(alignment: .leading, spacing: 20) {
                Text("Categories")
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
                    .padding(.bottom, 8)
                
                ForEach(PasswordCategory.allCases) { category in
                    CategoryRow(category: category, isSelected: selectedCategory == category) {
                        selectedCategory = category
                    }
                }
                
                Spacer()
                
                Button(action: { showAddPassword = true }) {
                    Label("Add Password", systemImage: "plus")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(GharTheme.accent)
                        .cornerRadius(8)
                }
            }
            .padding(20)
            .frame(width: 220)
            .background(GharTheme.cardBackground)
            
            // Main content
            VStack(alignment: .leading, spacing: 24) {
                // Header
                HStack {
                    Text(selectedCategory.rawValue)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(GharTheme.textPrimary)
                    
                    Spacer()
                    
                    TextField("Search passwords...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 220)
                }
                
                // Password security stats
                HStack(spacing: 16) {
                    SecurityStatCard(title: "Password Health", value: "82%", description: "Good", icon: "heart.fill", color: .green)
                    SecurityStatCard(title: "Compromised", value: "0", description: "None found", icon: "exclamationmark.shield.fill", color: .red)
                    SecurityStatCard(title: "Reused", value: "2", description: "Consider changing", icon: "arrow.triangle.2.circlepath", color: .orange)
                }
                
                // Password list
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Stored Passwords")
                            .font(.headline)
                            .foregroundColor(GharTheme.textPrimary)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Label("Export", systemImage: "square.and.arrow.up")
                                .font(.callout)
                                .foregroundColor(GharTheme.accent)
                        }
                    }
                    
                    List {
                        ForEach(filteredPasswords) { password in
                            PasswordRow(password: password)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(GharTheme.cardBackground)
                    .cornerRadius(12)
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(GharTheme.background)
        .sheet(isPresented: $showAddPassword) {
            AddPasswordView(isPresented: $showAddPassword)
        }
    }
    
    private var filteredPasswords: [PasswordItem] {
        let filtered = selectedCategory == .all 
            ? passwords 
            : passwords.filter { $0.category == selectedCategory }
        
        if searchText.isEmpty {
            return filtered
        } else {
            return filtered.filter { 
                $0.title.lowercased().contains(searchText.lowercased()) || 
                $0.username.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

struct CategoryRow: View {
    var category: PasswordsView.PasswordCategory
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: category.icon)
                    .font(.system(size: 16))
                    .foregroundColor(isSelected ? GharTheme.accent : GharTheme.textSecondary)
                    .frame(width: 20)
                
                Text(category.rawValue)
                    .font(.headline)
                    .foregroundColor(isSelected ? GharTheme.textPrimary : GharTheme.textSecondary)
                
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(isSelected ? GharTheme.accent.opacity(0.1) : Color.clear)
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SecurityStatCard: View {
    var title: String
    var value: String
    var description: String
    var icon: String
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(GharTheme.textPrimary)
            }
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(GharTheme.textPrimary)
            
            Text(description)
                .font(.caption)
                .foregroundColor(GharTheme.textSecondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(GharTheme.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct PasswordRow: View {
    var password: PasswordsView.PasswordItem
    @State private var isRevealed = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    private var isOld: Bool {
        let days = Calendar.current.dateComponents([.day], from: password.lastUpdated, to: Date()).day ?? 0
        return days > 90
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Text(String(password.title.prefix(1)).uppercased())
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(GharTheme.textPrimary)
            }
            
            // Details
            VStack(alignment: .leading, spacing: 4) {
                Text(password.title)
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
                
                Text(password.username)
                    .font(.subheadline)
                    .foregroundColor(GharTheme.textSecondary)
            }
            
            Spacer()
            
            // Last updated
            VStack(alignment: .trailing, spacing: 4) {
                HStack(spacing: 8) {
                    Circle()
                        .fill(password.strength.color)
                        .frame(width: 8, height: 8)
                    
                    Text(password.strength.rawValue)
                        .font(.caption)
                        .foregroundColor(GharTheme.textSecondary)
                }
                
                Text(isOld ? "Updated \(dateFormatter.string(from: password.lastUpdated))" : "Updated recently")
                    .font(.caption)
                    .foregroundColor(isOld ? GharTheme.warning : GharTheme.textSecondary)
            }
            
            // Actions
            HStack(spacing: 12) {
                Button(action: { isRevealed.toggle() }) {
                    Image(systemName: isRevealed ? "eye.slash" : "eye")
                        .font(.system(size: 16))
                        .foregroundColor(GharTheme.textSecondary)
                }
                
                Button(action: {}) {
                    Image(systemName: "doc.on.doc")
                        .font(.system(size: 16))
                        .foregroundColor(GharTheme.textSecondary)
                }
                
                Button(action: {}) {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 16))
                        .foregroundColor(GharTheme.textSecondary)
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
    }
}

struct AddPasswordView: View {
    @Binding var isPresented: Bool
    @State private var title = ""
    @State private var username = ""
    @State private var password = ""
    @State private var category: PasswordsView.PasswordCategory = .websites
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            HStack {
                Text("Add New Password")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(GharTheme.textPrimary)
                
                Spacer()
                
                Button(action: { isPresented = false }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(GharTheme.textSecondary)
                }
            }
            
            // Form
            Form {
                Section(header: Text("Account Information")) {
                    TextField("Title", text: $title)
                    TextField("Username or Email", text: $username)
                    SecureField("Password", text: $password)
                }
                
                Section(header: Text("Category")) {
                    Picker("Category", selection: $category) {
                        ForEach(PasswordsView.PasswordCategory.allCases.filter { $0 != .all }) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }
            }
            .formStyle(GroupedFormStyle())
            
            // Buttons
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Save Password") {
                    // Save the password
                    isPresented = false
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(24)
        .frame(width: 500, height: 400)
    }
}

// MARK: - Subscriptions View
struct SubscriptionsView: View {
    @State private var sortOption = SubSortOption.nextBilling
    @State private var showAddSubscription = false
    
    enum SubSortOption: String, CaseIterable, Identifiable {
        case name = "Name"
        case cost = "Cost"
        case nextBilling = "Next Billing"
        
        var id: String { self.rawValue }
    }
    
    private let subscriptions = SampleData.subscriptions
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Header
            HStack {
                Text("Subscriptions")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(GharTheme.textPrimary)
                
                Spacer()
                
                Button(action: { showAddSubscription = true }) {
                    Label("Add Subscription", systemImage: "plus")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(GharTheme.accent)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            
            // Summary cards
            HStack(spacing: 20) {
                SubscriptionInfoCard(
                    title: "Monthly Total",
                    value: "$27.97",
                    icon: "dollarsign.circle.fill",
                    color: .blue
                )
                
                SubscriptionInfoCard(
                    title: "Annual Cost",
                    value: "$335.64",
                    icon: "calendar",
                    color: .purple
                )
                
                SubscriptionInfoCard(
                    title: "Active Subscriptions",
                    value: "3",
                    icon: "checkmark.circle.fill",
                    color: .green
                )
                
                SubscriptionInfoCard(
                    title: "Upcoming Renewals",
                    value: "2 this month",
                    icon: "clock.fill",
                    color: .orange
                )
            }
            
            // Subscriptions list
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Your Subscriptions")
                        .font(.headline)
                        .foregroundColor(GharTheme.textPrimary)
                    
                    Spacer()
                    
                    Picker("Sort by", selection: $sortOption) {
                        ForEach(SubSortOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 150)
                }
                
                // Subscription Calendar
                Text("Upcoming Renewals")
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
                    .padding(.top, 16)
                
                SubscriptionCalendarView()
                
                Divider()
                    .padding(.vertical, 20)
                
                // Subscription list
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 320, maximum: 400), spacing: 20)
                ], spacing: 20) {
                    ForEach(sortedSubscriptions) { subscription in
                        SubscriptionCard(subscription: subscription)
                    }
                }
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(GharTheme.background)
        .sheet(isPresented: $showAddSubscription) {
            AddSubscriptionView(isPresented: $showAddSubscription)
        }
    }
    
    private var sortedSubscriptions: [Subscription] {
        switch sortOption {
        case .name:
            return subscriptions.sorted { $0.name < $1.name }
        case .cost:
            return subscriptions.sorted { $0.cost > $1.cost }
        case .nextBilling:
            return subscriptions.sorted { $0.nextBillingDate < $1.nextBillingDate }
        }
    }
}

struct SubscriptionInfoCard: View {
    var title: String
    var value: String
    var icon: String
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
                
                Spacer()
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(GharTheme.textSecondary)
                
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(GharTheme.textPrimary)
            }
        }
        .padding(16)
        .frame(height: 120)
        .background(GharTheme.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct SubscriptionCalendarView: View {
    // Sample upcoming dates
    private let upcomingDates = [
        (Date().addingTimeInterval(86400 * 3), "Netflix"),
        (Date().addingTimeInterval(86400 * 7), "Spotify"),
        (Date().addingTimeInterval(86400 * 20), "iCloud+")
    ]
    
    private let calendar = Calendar.current
    @State private var currentMonth = Calendar.current.component(.month, from: Date())
    
    var body: some View {
        VStack(spacing: 16) {
            // Month navigation
            HStack {
                Button(action: { decrementMonth() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(GharTheme.accent)
                }
                
                Spacer()
                
                Text(monthString())
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(GharTheme.textPrimary)
                
                Spacer()
                
                Button(action: { incrementMonth() }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(GharTheme.accent)
                }
            }
            
            // Calendar grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                // Day headers
                ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .foregroundColor(GharTheme.textSecondary)
                        .frame(height: 30)
                }
                
                // Day cells
                ForEach(daysInMonth(), id: \.self) { day in
                    if day > 0 {
                        DayCell(day: day, events: eventsForDay(day))
                    } else {
                        // Empty cell for padding
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 45)
                    }
                }
            }
        }
        .padding(16)
        .background(GharTheme.cardBackground)
        .cornerRadius(12)
    }
    
    private func monthString() -> String {
        let dateComponents = DateComponents(year: calendar.component(.year, from: Date()), month: currentMonth)
        let date = calendar.date(from: dateComponents)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    private func incrementMonth() {
        currentMonth = currentMonth == 12 ? 1 : currentMonth + 1
    }
    
    private func decrementMonth() {
        currentMonth = currentMonth == 1 ? 12 : currentMonth - 1
    }
    
    private func daysInMonth() -> [Int] {
        // Get first day of the month
        let dateComponents = DateComponents(year: calendar.component(.year, from: Date()), month: currentMonth)
        let firstDay = calendar.date(from: dateComponents)!
        
        // Calculate the weekday of the first day (0 = Sunday, 6 = Saturday)
        let firstWeekday = calendar.component(.weekday, from: firstDay) - 1
        
        // Get the number of days in the month
        let range = calendar.range(of: .day, in: .month, for: firstDay)!
        let numDays = range.count
        
        // Create array with leading zeros for padding and then the days
        var days = Array(repeating: 0, count: firstWeekday)
        days.append(contentsOf: 1...numDays)
        
        return days
    }
    
    private func eventsForDay(_ day: Int) -> [String] {
        let dateComponents = DateComponents(year: calendar.component(.year, from: Date()), month: currentMonth, day: day)
        guard let date = calendar.date(from: dateComponents) else { return [] }
        
        return upcomingDates
            .filter { calendar.isDate($0.0, inSameDayAs: date) }
            .map { $0.1 }
    }
}

struct DayCell: View {
    var day: Int
    var events: [String]
    
    private var isToday: Bool {
        let calendar = Calendar.current
        return calendar.component(.day, from: Date()) == day &&
               calendar.component(.month, from: Date()) == calendar.component(.month, from: Date())
    }
    
    var body: some View {
        VStack(spacing: 4) {
            // Day number
            Text("\(day)")
                .font(.callout)
                .fontWeight(isToday ? .bold : .regular)
                .foregroundColor(isToday ? .white : GharTheme.textPrimary)
                .frame(width: 30, height: 30)
                .background(isToday ? GharTheme.accent : Color.clear)
                .clipShape(Circle())
            
            // Event dots
            HStack(spacing: 4) {
                ForEach(events.prefix(3), id: \.self) { event in
                    Circle()
                        .fill(dotColor(for: event))
                        .frame(width: 6, height: 6)
                }
                
                if events.count > 3 {
                    Text("+\(events.count - 3)")
                        .font(.system(size: 8))
                        .foregroundColor(GharTheme.textSecondary)
                }
            }
        }
        .frame(height: 45)
    }
    
    private func dotColor(for event: String) -> Color {
        switch event.lowercased() {
        case "netflix": return .red
        case "spotify": return .green
        case "icloud+": return .blue
        default: return GharTheme.accent
        }
    }
}

struct SubscriptionCard: View {
    var subscription: Subscription
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    private var isUpcomingSoon: Bool {
        let days = Calendar.current.dateComponents([.day], from: Date(), to: subscription.nextBillingDate).day ?? 0
        return days <= 7
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Circle()
                    .fill(subscriptionColor(for: subscription.name))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(subscription.name.prefix(1).uppercased())
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(subscription.name)
                        .font(.headline)
                        .foregroundColor(GharTheme.textPrimary)
                    
                    Text(subscription.billingCycle.rawValue)
                        .font(.subheadline)
                        .foregroundColor(GharTheme.textSecondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("$\(String(format: "%.2f", subscription.cost))")
                        .font(.headline)
                        .foregroundColor(GharTheme.textPrimary)
                    
                    Text("per \(subscription.billingCycle.rawValue.lowercased())")
                        .font(.caption)
                        .foregroundColor(GharTheme.textSecondary)
                }
            }
            
            Divider()
            
            // Next billing
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Next billing")
                        .font(.callout)
                        .foregroundColor(GharTheme.textSecondary)
                    
                    Text(dateFormatter.string(from: subscription.nextBillingDate))
                        .font(.subheadline)
                        .foregroundColor(isUpcomingSoon ? GharTheme.warning : GharTheme.textPrimary)
                }
                
                Spacer()
                
                // Annual cost
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Annual cost")
                        .font(.callout)
                        .foregroundColor(GharTheme.textSecondary)
                    
                    Text("$\(String(format: "%.2f", annualCost(subscription)))")
                        .font(.subheadline)
                        .foregroundColor(GharTheme.textPrimary)
                }
            }
            
            // Action buttons
            HStack {
                Button(action: {}) {
                    Label("Edit", systemImage: "pencil")
                        .font(.callout)
                        .foregroundColor(GharTheme.accent)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Label("Cancel", systemImage: "xmark.circle")
                        .font(.callout)
                        .foregroundColor(Color.red)
                }
            }
            .padding(.top, 8)
        }
        .padding(16)
        .background(GharTheme.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    private func subscriptionColor(for name: String) -> Color {
        switch name.lowercased() {
        case "netflix": return .red
        case "spotify": return .green
        case "icloud+": return .blue
        default: return GharTheme.accent
        }
    }
    
    private func annualCost(_ subscription: Subscription) -> Double {
        switch subscription.billingCycle {
        case .monthly: return subscription.cost * 12
        case .quarterly: return subscription.cost * 4
        case .yearly: return subscription.cost
        }
    }
}

struct AddSubscriptionView: View {
    @Binding var isPresented: Bool
    @State private var name = ""
    @State private var cost = ""
    @State private var billingCycle = BillingCycle.monthly
    @State private var nextBillingDate = Date()
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            HStack {
                Text("Add New Subscription")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(GharTheme.textPrimary)
                
                Spacer()
                
                Button(action: { isPresented = false }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(GharTheme.textSecondary)
                }
            }
            
            // Form
            Form {
                Section(header: Text("Subscription Details")) {
                    TextField("Name", text: $name)
                    TextField("Cost", text: $cost)
                    
                    Picker("Billing Cycle", selection: $billingCycle) {
                        ForEach(BillingCycle.allCases, id: \.self) { cycle in
                            Text(cycle.rawValue).tag(cycle)
                        }
                    }
                    
                    DatePicker("Next Billing Date", selection: $nextBillingDate, displayedComponents: .date)
                }
            }
            .formStyle(GroupedFormStyle())
            
            // Buttons
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Add Subscription") {
                    // Save the subscription
                    isPresented = false
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(24)
        .frame(width: 500, height: 400)
    }
}

// MARK: - Dashboard View
struct DashboardView: View {
    // Property to handle window resizing
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var selectedTimeFrame: TimeFrame = .month
    @State private var showingFinancialTips = false
    @State private var refreshing = false
    
    // Sample weather data
    private let weatherCondition = "Partly Cloudy"
    private let temperature = "72°F"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Enhanced Dashboard header with weather info
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [GharTheme.accent.opacity(0.8), GharTheme.accent]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .shadow(color: GharTheme.accent.opacity(0.3), radius: 10, x: 0, y: 5)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(getGreeting())
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                            
                            HStack(spacing: 12) {
                                Text(currentDate)
                                    .font(.title3)
                                    .foregroundColor(.white.opacity(0.9))
                                
                                Circle()
                                    .fill(.white.opacity(0.8))
                                    .frame(width: 4, height: 4)
                                
                                Text(timeGreeting())
                                    .font(.title3)
                                    .foregroundColor(.white.opacity(0.9))
                            }
                        }
                        
                        Spacer()
                        
                        // Weather widget
                        VStack(alignment: .trailing, spacing: 4) {
                            HStack {
                                Image(systemName: weatherIcon())
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                                
                                Text(temperature)
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }
                            
                            Text(weatherCondition)
                                .font(.callout)
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)
                }
                .frame(height: 120)
                
                // Refresh indicator and time frame selector
                HStack {
                    Text("Overview")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(GharTheme.textPrimary)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            refreshing = true
                            // Simulate refresh
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                refreshing = false
                            }
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 16))
                            .foregroundColor(GharTheme.accent)
                            .rotationEffect(Angle(degrees: refreshing ? 360 : 0))
                            .animation(refreshing ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default, value: refreshing)
                    }
                    .padding(.trailing, 8)
                    
                    TimeFramePicker(selectedTimeFrame: $selectedTimeFrame)
                }
                .padding(.top, 8)
                
                // Summary tiles
                SummaryTilesView()
                
                // Financial tips banner
                financialTipsBanner()
                    .onTapGesture {
                        showingFinancialTips.toggle()
                    }
                
                // Dashboard cards
                adaptiveGridLayout {
                    ExpensesCard()
                    BillsCard()
                    SubscriptionsCard()
                    TodoCard()
                }
                
                // New section: Quick Actions
                VStack(alignment: .leading, spacing: 16) {
                    Text("Quick Actions")
                        .font(.headline)
                        .foregroundColor(GharTheme.textPrimary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            QuickActionButton(title: "Pay Bills", icon: "dollarsign.circle.fill", color: .blue)
                            QuickActionButton(title: "Add Expense", icon: "plus.circle.fill", color: .green)
                            QuickActionButton(title: "View Budget", icon: "chart.pie.fill", color: .purple)
                            QuickActionButton(title: "Set Reminder", icon: "bell.fill", color: .orange)
                            QuickActionButton(title: "Create Goal", icon: "flag.fill", color: .red)
                        }
                    }
                }
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(GharTheme.background)
        .sheet(isPresented: $showingFinancialTips) {
            FinancialTipsView()
        }
    }
    
    // Function to create adaptive grid layout based on screen size
    @ViewBuilder
    private func adaptiveGridLayout<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        if horizontalSizeClass == .compact {
            // Single column layout for smaller screens
            VStack(spacing: 20) {
                content()
            }
        } else {
            // Multi-column grid for larger screens
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 320, maximum: 420), spacing: 20)
            ], spacing: 20) {
                content()
            }
        }
    }
    
    // Get current date for the greeting
    private var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: Date())
    }
    
    // Return appropriate greeting based on time of day
    private func timeGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        if hour < 12 {
            return "Good morning"
        } else if hour < 17 {
            return "Good afternoon"
        } else {
            return "Good evening"
        }
    }
    
    // Personalized greeting with name
    private func getGreeting() -> String {
        return "Welcome back, Alex"
    }
    
    // Weather icon based on condition
    private func weatherIcon() -> String {
        switch weatherCondition {
        case "Sunny":
            return "sun.max.fill"
        case "Partly Cloudy":
            return "cloud.sun.fill"
        case "Cloudy":
            return "cloud.fill"
        case "Rainy":
            return "cloud.rain.fill"
        case "Snowy":
            return "cloud.snow.fill"
        default:
            return "sun.max.fill"
        }
    }
    
    // Financial tips banner
    @ViewBuilder
    private func financialTipsBanner() -> some View {
        HStack {
            Image(systemName: "lightbulb.fill")
                .font(.system(size: 24))
                .foregroundColor(.yellow)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Financial Tip of the Day")
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
                
                Text("Setting up automatic transfers to savings can help you build emergency funds faster.")
                    .font(.subheadline)
                    .foregroundColor(GharTheme.textSecondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(GharTheme.textSecondary)
        }
        .padding(16)
        .background(GharTheme.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// Financial Tips View
struct FinancialTipsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    struct Tip: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let icon: String
    }
    
    private let tips = [
        Tip(title: "50/30/20 Rule", description: "Allocate 50% of income to needs, 30% to wants, and 20% to savings and debt repayment.", icon: "chart.pie.fill"),
        Tip(title: "Emergency Fund", description: "Aim to have 3-6 months of expenses saved in an easily accessible account.", icon: "lifepreserver.fill"),
        Tip(title: "Pay Yourself First", description: "Set up automatic transfers to your savings account when you get paid.", icon: "arrow.left.arrow.right"),
        Tip(title: "High-Interest Debt", description: "Prioritize paying off high-interest debt like credit cards before focusing on lower-interest loans.", icon: "creditcard.fill"),
        Tip(title: "Retirement Savings", description: "Contribute enough to your 401(k) to get the full employer match—it's free money!", icon: "clock.fill")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tips) { tip in
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(GharTheme.accent.opacity(0.2))
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: tip.icon)
                                .font(.system(size: 22))
                                .foregroundColor(GharTheme.accent)
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(tip.title)
                                .font(.headline)
                                .foregroundColor(GharTheme.textPrimary)
                            
                            Text(tip.description)
                                .font(.subheadline)
                                .foregroundColor(GharTheme.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            // Change ListStyle for macOS
            .listStyle(DefaultListStyle())
            .navigationTitle("Financial Tips")
            .toolbar {
                // Use ToolbarItem with default placement for macOS
                ToolbarItem {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

// Quick Action Button
struct QuickActionButton: View {
    var title: String
    var icon: String
    var color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(color)
            }
            
            Text(title)
                .font(.callout)
                .foregroundColor(GharTheme.textPrimary)
        }
        .frame(width: 100)
    }
}

// MARK: - Summary Tiles View
struct SummaryTilesView: View {
    var timeFrame: TimeFrame
    
    var body: some View {
        HStack(spacing: 16) {
            SummaryTile(
                title: "Total Expenses",
                value: expenseValue(),
                change: -4.5,
                icon: "dollarsign.square.fill",
                iconColor: .blue
            )
            
            SummaryTile(
                title: "Upcoming Bills",
                value: "$845.75",
                change: 2.1,
                icon: "calendar.badge.clock",
                iconColor: .orange
            )
            
            SummaryTile(
                title: "Active Subscriptions",
                value: "$128.97",
                change: 0.0,
                icon: "repeat.circle.fill",
                iconColor: .purple
            )
            
            SummaryTile(
                title: "Savings",
                value: savingsValue(),
                change: 6.8,
                icon: "chart.line.uptrend.xyaxis",
                iconColor: .green
            )
        }
    }
    
    // Dynamic values based on selected time frame
    private func expenseValue() -> String {
        switch timeFrame {
        case .week:
            return "$750.20"
        case .month:
            return "$3,250.45"
        case .quarter:
            return "$9,750.30"
        case .year:
            return "$39,005.60"
        }
    }
    
    private func savingsValue() -> String {
        switch timeFrame {
        case .week:
            return "$425.00"
        case .month:
            return "$1,450.00"
        case .quarter:
            return "$4,350.00"
        case .year:
            return "$17,400.00"
        }
    }
}

// MARK: - Enhanced Expenses Card
struct ExpensesCard: View {
    var timeFrame: TimeFrame
    
    var body: some View {
        DashboardCard(title: "\(timeFrame.rawValue)ly Expenses", icon: "dollarsign.circle.fill") {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(expenseValue())
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(GharTheme.textPrimary)
                        
                        HStack {
                            Image(systemName: "arrow.down")
                                .foregroundColor(GharTheme.success)
                            
                            Text("4.5% less than last \(timeFrame.rawValue.lowercased())")
                                .font(.callout)
                                .foregroundColor(GharTheme.success)
                        }
                    }
                    
                    Spacer()
                    
                    // Enhanced chart visualization
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.blue.opacity(0.1))
                            .frame(width: 80, height: 40)
                        
                        Path { path in
                            let width: CGFloat = 70
                            let height: CGFloat = 30
                            
                            // Sample data points
                            let points: [CGFloat] = [0.2, 0.5, 0.3, 0.8, 0.4, 0.6, 0.7]
                            
                            // Starting point
                            path.move(to: CGPoint(x: 5, y: height - (points[0] * height)))
                            
                            // Draw lines between points
                            for i in 1..<points.count {
                                let x = 5 + (width / CGFloat(points.count - 1)) * CGFloat(i)
                                let y = height - (points[i] * height)
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                        }
                        .stroke(Color.blue, lineWidth: 2)
                    }
                }
                
                Divider()
                
                // Top expense categories
                Text("Top Categories")
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
                
                ExpenseCategoryRow(name: "Housing", amount: housingAmount(), color: .blue, percentage: 60)
                ExpenseCategoryRow(name: "Utilities", amount: utilitiesAmount(), color: .purple, percentage: 20)
                ExpenseCategoryRow(name: "Groceries", amount: groceriesAmount(), color: .green, percentage: 15)
                
                Button(action: {}) {
                    HStack {
                        Spacer()
                        Text("View All Expenses")
                            .fontWeight(.medium)
                        Spacer()
                    }
                }
                .buttonStyle(.bordered)
                .controlSize(.regular)
                .padding(.top, 8)
            }
        }
    }
    
    // Dynamic values based on time frame
    private func expenseValue() -> String {
        switch timeFrame {
        case .week:
            return "$750.20"
        case .month:
            return "$3,250.45"
        case .quarter:
            return "$9,750.30"
        case .year:
            return "$39,005.60"
        }
    }
    
    private func housingAmount() -> String {
        switch timeFrame {
        case .week:
            return "$450.00"
        case .month:
            return "$1,950.00"
        case .quarter:
            return "$5,850.00"
        case .year:
            return "$23,400.00"
        }
    }
    
    private func utilitiesAmount() -> String {
        switch timeFrame {
        case .week:
            return "$54.25"
        case .month:
            return "$235.50"
        case .quarter:
            return "$706.50"
        case .year:
            return "$2,826.00"
        }
    }
    
    private func groceriesAmount() -> String {
        switch timeFrame {
        case .week:
            return "$43.65"
        case .month:
            return "$189.25"
        case .quarter:
            return "$567.75"
        case .year:
            return "$2,271.00"
        }
    }
}

// MARK: - Bills View
struct BillsView: View {
    @State private var selectedTab = 0
    @State private var showAddBill = false
    @State private var searchText = ""
    
    // Sample bills data
    private let bills = [
        Bill(name: "Electricity", amount: 125.50, dueDate: Date().addingTimeInterval(86400 * 5), isRecurring: true, category: .utilities),
        Bill(name: "Water", amount: 78.30, dueDate: Date().addingTimeInterval(86400 * 10), isRecurring: true, category: .utilities),
        Bill(name: "Mortgage", amount: 1450.00, dueDate: Date().addingTimeInterval(86400 * 15), isRecurring: true, category: .housing),
        Bill(name: "Internet", amount: 89.99, dueDate: Date().addingTimeInterval(86400 * 20), isRecurring: true, category: .utilities),
        Bill(name: "Car Payment", amount: 375.00, dueDate: Date().addingTimeInterval(86400 * 8), isRecurring: true, category: .transportation)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Header
            HStack {
                Text("Bills")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(GharTheme.textPrimary)
                
                Spacer()
                
                // Search field
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(GharTheme.textSecondary)
                    
                    TextField("Search bills...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(8)
                .background(GharTheme.cardBackground)
                .cornerRadius(8)
                .frame(width: 220)
                
                Button(action: { showAddBill = true }) {
                    Label("Add Bill", systemImage: "plus")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(GharTheme.accent)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            
            // Bill summary cards
            HStack(spacing: 20) {
                BillSummaryCard(title: "Total Due", value: "$\(totalDue())", icon: "dollarsign.circle.fill", color: .blue)
                BillSummaryCard(title: "Due This Week", value: dueThisWeek(), icon: "calendar", color: .red)
                BillSummaryCard(title: "Due Next Week", value: dueNextWeek(), icon: "calendar.badge.clock", color: .orange)
                BillSummaryCard(title: "Paid This Month", value: "$1,245.80", icon: "checkmark.circle.fill", color: .green)
            }
            
            // Tabs
            HStack(spacing: 20) {
                TabButton(title: "Upcoming", isActive: selectedTab == 0) {
                    selectedTab = 0
                }
                
                TabButton(title: "History", isActive: selectedTab == 1) {
                    selectedTab = 1
                }
                
                TabButton(title: "Recurring", isActive: selectedTab == 2) {
                    selectedTab = 2
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            
            // Tab content
            if selectedTab == 0 {
                UpcomingBillsView(bills: sortedBills)
            } else if selectedTab == 1 {
                BillHistoryView()
            } else {
                RecurringBillsView(bills: recurringBills)
            }
            
            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(GharTheme.background)
        .sheet(isPresented: $showAddBill) {
            AddBillView(isPresented: $showAddBill)
        }
    }
    
    private var sortedBills: [Bill] {
        bills.sorted { $0.dueDate < $1.dueDate }
    }
    
    private var recurringBills: [Bill] {
        bills.filter { $0.isRecurring }
    }
    
    private func totalDue() -> String {
        let total = bills.reduce(0) { $0 + $1.amount }
        return String(format: "%.2f", total)
    }
    
    private func dueThisWeek() -> String {
        let today = Date()
        let endOfWeek = Calendar.current.date(byAdding: .day, value: 7, to: today)!
        let thisWeekBills = bills.filter { $0.dueDate >= today && $0.dueDate <= endOfWeek }
        let total = thisWeekBills.reduce(0) { $0 + $1.amount }
        return "$" + String(format: "%.2f", total)
    }
    
    private func dueNextWeek() -> String {
        let startNextWeek = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
        let endNextWeek = Calendar.current.date(byAdding: .day, value: 14, to: Date())!
        let nextWeekBills = bills.filter { $0.dueDate >= startNextWeek && $0.dueDate <= endNextWeek }
        let total = nextWeekBills.reduce(0) { $0 + $1.amount }
        return "$" + String(format: "%.2f", total)
    }
}

// Tab Button for bill view
struct TabButton: View {
    var title: String
    var isActive: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(isActive ? GharTheme.accent : GharTheme.textSecondary)
                .padding(.bottom, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(isActive ? GharTheme.accent : Color.clear)
                        .offset(y: 4),
                    alignment: .bottom
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Placeholder tab for unimplemented content
struct PlaceholderTab: View {
    var title: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "hammer.fill")
                .font(.system(size: 40))
                .foregroundColor(GharTheme.textSecondary.opacity(0.5))
                .padding(.bottom, 16)
            
            Text("\(title) coming soon")
                .font(.headline)
                .foregroundColor(GharTheme.textSecondary)
            
            Spacer()
        }
        .frame(height: 250)
    }
}

// Add AddVehicleButton after EnhancedVehicleCard
struct AddVehicleButton: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 32))
                .foregroundColor(GharTheme.accent)
            
            Text("Add Vehicle")
                .font(.headline)
                .foregroundColor(GharTheme.textPrimary)
            
            Spacer()
        }
        .padding(16)
        .frame(width: 180, height: 160)
        .background(GharTheme.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(GharTheme.accent.opacity(0.3), lineWidth: 1)
                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
        )
    }
}

// Add these bill view components after BillsView
struct BillSummaryCard: View {
    var title: String
    var value: String
    var icon: String
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
                
                Spacer()
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.callout)
                    .foregroundColor(GharTheme.textSecondary)
                
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(GharTheme.textPrimary)
            }
        }
        .padding(16)
        .frame(height: 120)
        .background(GharTheme.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct UpcomingBillsView: View {
    var bills: [Bill]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(bills) { bill in
                BillRow(bill: bill)
            }
        }
        .background(GharTheme.cardBackground)
        .cornerRadius(12)
    }
}

struct BillRow: View {
    var bill: Bill
    @State private var isPaid: Bool = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    private var isDueSoon: Bool {
        let days = Calendar.current.dateComponents([.day], from: Date(), to: bill.dueDate).day ?? 0
        return days <= 3 && days >= 0
    }
    
    var body: some View {
        HStack {
            // Category icon
            ZStack {
                Circle()
                    .fill(categoryColor.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: bill.category.icon)
                    .font(.system(size: 16))
                    .foregroundColor(categoryColor)
            }
            
            // Bill details
            VStack(alignment: .leading, spacing: 4) {
                Text(bill.name)
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
                
                HStack {
                    Text(bill.category.rawValue)
                        .font(.subheadline)
                        .foregroundColor(GharTheme.textSecondary)
                    
                    if bill.isRecurring {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.system(size: 10))
                            .foregroundColor(GharTheme.textSecondary)
                    }
                }
            }
            
            Spacer()
            
            // Due date
            VStack(alignment: .trailing, spacing: 4) {
                Text("Due \(dateFormatter.string(from: bill.dueDate))")
                    .font(.subheadline)
                    .foregroundColor(isDueSoon ? .red : GharTheme.textSecondary)
                
                Text("$\(String(format: "%.2f", bill.amount))")
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
            }
            
            // Payment button
            Button(action: { isPaid.toggle() }) {
                Image(systemName: isPaid ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(isPaid ? .green : GharTheme.textSecondary)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.leading, 16)
        }
        .padding(16)
        .background(GharTheme.cardBackground)
        .cornerRadius(8)
    }
    
    private var categoryColor: Color {
        switch bill.category {
        case .utilities: return .blue
        case .housing: return .purple
        case .transportation: return .orange
        case .insurance: return .green
        case .entertainment: return .pink
        case .other: return .gray
        }
    }
}

struct BillHistoryView: View {
    var body: some View {
        PlaceholderTab(title: "Bill History")
    }
}

struct RecurringBillsView: View {
    var bills: [Bill]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(bills) { bill in
                BillRow(bill: bill)
            }
        }
        .background(GharTheme.cardBackground)
        .cornerRadius(12)
    }
}

struct AddBillView: View {
    @Binding var isPresented: Bool
    @State private var name = ""
    @State private var amount = ""
    @State private var dueDate = Date()
    @State private var isRecurring = false
    @State private var category: Bill.BillCategory = .utilities
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Bill Information")) {
                    TextField("Bill Name", text: $name)
                    TextField("Amount", text: $amount)
                    
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    
                    Toggle("Recurring Bill", isOn: $isRecurring)
                    
                    Picker("Category", selection: $category) {
                        ForEach(Bill.BillCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        // Save bill
                        isPresented = false
                    }) {
                        Text("Save Bill")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .foregroundColor(.white)
                    .listRowBackground(GharTheme.accent)
                    
                    Button(action: { isPresented = false }) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .foregroundColor(GharTheme.textSecondary)
                }
            }
            .navigationTitle("Add New Bill")
        }
        .frame(width: 500, height: 500)
    }
}

// Add TimeFramePicker 
struct TimeFramePicker: View {
    @Binding var selectedTimeFrame: TimeFrame
    
    var body: some View {
        Picker("Time Frame", selection: $selectedTimeFrame) {
            ForEach(TimeFrame.allCases) { timeFrame in
                Text(timeFrame.rawValue).tag(timeFrame)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(width: 300)
    }
}

// Add SummaryTile
struct SummaryTile: View {
    var title: String
    var value: String
    var change: Double
    var icon: String
    var iconColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(iconColor)
                
                Spacer()
                
                if change != 0 {
                    HStack(spacing: 2) {
                        Image(systemName: change > 0 ? "arrow.up" : "arrow.down")
                            .font(.system(size: 10))
                            .foregroundColor(change > 0 ? .red : .green)
                        
                        Text("\(abs(change), specifier: "%.1f")%")
                            .font(.caption2)
                            .foregroundColor(change > 0 ? .red : .green)
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(change > 0 ? Color.red.opacity(0.1) : Color.green.opacity(0.1))
                    )
                }
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.callout)
                    .foregroundColor(GharTheme.textSecondary)
                
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(GharTheme.textPrimary)
            }
        }
        .padding(16)
        .frame(height: 120)
        .background(GharTheme.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// Add DashboardCard
struct DashboardCard<Content: View>: View {
    var title: String
    var icon: String
    var content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Card header
            HStack {
                Label(title, systemImage: icon)
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .foregroundColor(GharTheme.textSecondary)
            }
            
            // Card content
            content
        }
        .padding(16)
        .background(GharTheme.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// Add ExpenseCategoryRow
struct ExpenseCategoryRow: View {
    var name: String
    var amount: String
    var color: Color
    var percentage: Double
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(name)
                    .font(.subheadline)
                    .foregroundColor(GharTheme.textPrimary)
                
                Spacer()
                
                Text(amount)
                    .font(.subheadline)
                    .foregroundColor(GharTheme.textPrimary)
                    .fontWeight(.medium)
            }
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 6)
                        .opacity(0.2)
                        .foregroundColor(Color.gray)
                    
                    Rectangle()
                        .frame(width: min(CGFloat(percentage) / 100.0 * geometry.size.width, geometry.size.width), height: 6)
                        .foregroundColor(color)
                }
                .cornerRadius(3)
            }
            .frame(height: 6)
        }
    }
}

// Add missing dashboard cards
struct BillsCard: View {
    // Sample upcoming bills
    private let upcomingBills = [
        (name: "Electricity", amount: 125.50, dueIn: "3 days"),
        (name: "Internet", amount: 89.99, dueIn: "1 week"),
        (name: "Mortgage", amount: 1450.00, dueIn: "2 weeks")
    ]
    
    var body: some View {
        DashboardCard(title: "Upcoming Bills", icon: "calendar") {
            VStack(alignment: .leading, spacing: 16) {
                Text("$1,665.49 due this month")
                    .font(.headline)
                    .foregroundColor(GharTheme.textPrimary)
                
                Divider()
                
                ForEach(upcomingBills, id: \.name) { bill in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(bill.name)
                                .font(.subheadline)
                                .foregroundColor(GharTheme.textPrimary)
                            
                            Text("Due in \(bill.dueIn)")
                                .font(.caption)
                                .foregroundColor(GharTheme.textSecondary)
                        }
                        
                        Spacer()
                        
                        Text("$\(String(format: "%.2f", bill.amount))")
                            .font(.subheadline)
                            .foregroundColor(GharTheme.textPrimary)
                    }
                    .padding(.vertical, 6)
                    
                    if bill.name != upcomingBills.last?.name {
                        Divider()
                    }
                }
                
                Button(action: {}) {
                    HStack {
                        Spacer()
                        Text("View All Bills")
                            .fontWeight(.medium)
                        Spacer()
                    }
                }
                .buttonStyle(.bordered)
                .controlSize(.regular)
                .padding(.top, 8)
            }
        }
    }
}

struct SubscriptionsCard: View {
    var body: some View {
        DashboardCard(title: "Subscriptions", icon: "repeat.circle") {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("$92.97")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(GharTheme.textPrimary)
                        
                        Text("Monthly")
                            .font(.subheadline)
                            .foregroundColor(GharTheme.textSecondary)
                    }
                    
                    Spacer()
                    
                    Text("3 active")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(GharTheme.accent)
                        .cornerRadius(20)
                }
                
                Divider()
                
                SubscriptionItem(name: "Netflix", price: "$17.99", renewsOn: "May 15")
                SubscriptionItem(name: "Spotify", price: "$9.99", renewsOn: "May 22")
                SubscriptionItem(name: "iCloud+", price: "$2.99", renewsOn: "May 28")
                
                Button(action: {}) {
                    HStack {
                        Spacer()
                        Text("Manage Subscriptions")
                            .fontWeight(.medium)
                        Spacer()
                    }
                }
                .buttonStyle(.bordered)
                .controlSize(.regular)
                .padding(.top, 8)
            }
        }
    }
}

struct SubscriptionItem: View {
    var name: String
    var price: String
    var renewsOn: String
    
    var body: some View {
        HStack {
            Circle()
                .fill(subscriptionColor(for: name))
                .frame(width: 32, height: 32)
                .overlay(
                    Text(name.prefix(1))
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.subheadline)
                    .foregroundColor(GharTheme.textPrimary)
                
                Text("Renews on \(renewsOn)")
                    .font(.caption)
                    .foregroundColor(GharTheme.textSecondary)
            }
            
            Spacer()
            
            Text(price)
                .font(.subheadline)
                .foregroundColor(GharTheme.textPrimary)
        }
        .padding(.vertical, 6)
    }
    
    private func subscriptionColor(for name: String) -> Color {
        switch name.lowercased() {
        case "netflix": return .red
        case "spotify": return .green
        case "icloud+": return .blue
        default: return GharTheme.accent
        }
    }
}

struct TodoCard: View {
    @State private var tasks = [
        Task(title: "Pay electricity bill", isCompleted: false, dueDate: "Today"),
        Task(title: "Update car insurance", isCompleted: false, dueDate: "Tomorrow"),
        Task(title: "Service vehicle", isCompleted: true, dueDate: "Completed"),
        Task(title: "Review monthly budget", isCompleted: false, dueDate: "May 20")
    ]
    
    var body: some View {
        DashboardCard(title: "Tasks", icon: "checklist") {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("\(pendingTasks) pending")
                        .font(.headline)
                        .foregroundColor(GharTheme.textPrimary)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .foregroundColor(GharTheme.accent)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Divider()
                
                ForEach(Array(tasks.enumerated()), id: \.element.id) { index, task in
                    HStack {
                        Button(action: {
                            toggleTask(at: index)
                        }) {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : GharTheme.textSecondary)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Text(task.title)
                            .font(.subheadline)
                            .foregroundColor(task.isCompleted ? GharTheme.textSecondary : GharTheme.textPrimary)
                            .strikethrough(task.isCompleted)
                        
                        Spacer()
                        
                        Text(task.dueDate)
                            .font(.caption)
                            .foregroundColor(task.dueDate == "Today" ? .red : GharTheme.textSecondary)
                    }
                    .padding(.vertical, 4)
                }
                
                Button(action: {}) {
                    HStack {
                        Spacer()
                        Text("View All Tasks")
                            .fontWeight(.medium)
                        Spacer()
                    }
                }
                .buttonStyle(.bordered)
                .controlSize(.regular)
                .padding(.top, 8)
            }
        }
    }
    
    private var pendingTasks: Int {
        tasks.filter { !$0.isCompleted }.count
    }
    
    private func toggleTask(at index: Int) {
        tasks[index].isCompleted.toggle()
    }
}

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
    var dueDate: String
}

#Preview {
    ContentView()
}

