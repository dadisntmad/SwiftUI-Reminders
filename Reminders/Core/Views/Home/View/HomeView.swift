import SwiftUI
import SwipeActions

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Colors.background.ignoresSafeArea()
                
                VStack {
                    ScrollView(showsIndicators: false) {
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
                        
                        MyListsTextView()
                        
                        LazyVStack(spacing: 0) {
                            ForEach(0 ..< 25) { _ in
                                NavigationLink {
                                    ReminderDetailsView()
                                        .navigationTitle("Reminder")
                                        .navigationBarTitleDisplayMode(.large)
                                } label: {
                                    ListContainerView(circleColor: .orange, title: "Reminder", imagePath: "list.bullet", count: 3)
                                        .foregroundStyle(Color.black)
                                        .addSwipeAction(edge: .trailing) {
                                            Button {
                                                
                                            } label: {
                                                Image(systemName: "trash")
                                                    .frame(width: 70, height: 54, alignment: .center)
                                                    .foregroundColor(.white)
                                                    .background(Color.red)
                                            }
                                        }
                                }
                                
                                Divider()
                                    .padding(.leading, 60)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    ActionButtons()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
