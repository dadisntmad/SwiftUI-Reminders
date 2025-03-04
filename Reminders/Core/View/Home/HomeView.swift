import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            HStack(spacing: 15) {
                ReminderContainerView(
                    imagePath: nil,
                    count: 5,
                    title: "Today",
                    circleFillColor: Color.blue,
                    isSystemImage: false,
                    isDateCircle: true
                )
                
                ReminderContainerView(
                    imagePath: "calendar",
                    count: 3,
                    title: "Scheduled",
                    circleFillColor: Colors.red,
                    isSystemImage: true,
                    isDateCircle: false
                )
            }
            
            HStack(spacing: 15) {
                ReminderContainerView(
                    imagePath: "allReminders",
                    count: 5,
                    title: "All",
                    circleFillColor: Color.black,
                    isSystemImage: false,
                    isDateCircle: false
                )
                
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

#Preview {
    ZStack {
        Colors.background.ignoresSafeArea()
        
        HomeView()
    }
}
