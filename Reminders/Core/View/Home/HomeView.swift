import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack(spacing: 15) {
                    NavigationLink {
                        Text("Today")
                    } label: {
                        ReminderContainerView(
                            imagePath: nil,
                            count: 5,
                            title: "Today",
                            circleFillColor: Color.blue,
                            isSystemImage: false,
                            isDateCircle: true
                        )
                    }
                    
                    NavigationLink {
                        Text("Scheduled")
                    } label: {
                        ReminderContainerView(
                            imagePath: "calendar",
                            count: 3,
                            title: "Scheduled",
                            circleFillColor: Colors.red,
                            isSystemImage: true,
                            isDateCircle: false
                        )
                    }
                    
                }
                
                HStack(spacing: 15) {
                    NavigationLink {
                        Text("All")
                    } label: {
                        ReminderContainerView(
                            imagePath: "allReminders",
                            count: 5,
                            title: "All",
                            circleFillColor: Color.black,
                            isSystemImage: false,
                            isDateCircle: false
                        )
                    }
                    
                    NavigationLink {
                        Text("Completed")
                    } label: {
                        ReminderContainerView(
                            imagePath: "checkmark",
                            count: 17,
                            title: "Completed",
                            circleFillColor: Colors.gray90,
                            isSystemImage: true,
                            isDateCircle: false
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ZStack {
            Colors.background.ignoresSafeArea()
            
            HomeView()
        }
    }
}
