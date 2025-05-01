import SwiftUI
import SwipeActions

struct HomeView: View {
    @State private var homeViewModel = HomeViewModel()
    @State private var addListSheetViewModel = AddListSheetViewModel()
    
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
                                    count: homeViewModel.todaysReminders.count,
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
                                    count: homeViewModel.scheduledReminders.count,
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
                                    count: homeViewModel.reminders.count,
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
                                    count: homeViewModel.completedReminders.count,
                                    title: "Completed",
                                    circleFillColor: Colors.gray90,
                                    isSystemImage: true,
                                    isDateCircle: false
                                )
                            }
                        }
                        
                        if !homeViewModel.lists.isEmpty {
                            MyListsTextView()
                            
                            LazyVStack(spacing: 0) {
                                ForEach(homeViewModel.lists) { list in
                                    NavigationLink {
                                        ReminderDetailsView()
                                            .navigationTitle(list.reminderTitle ?? "")
                                            .navigationBarTitleDisplayMode(.large)
                                    } label: {
                                        ListContainerView(
                                            circleColor: Color.from(name: list.reminderColor ?? "orange"),
                                            title: list.reminderTitle ?? "",
                                            imagePath: list.reminderIcon ?? "list.bullet",
                                            count: (list.reminders as? Set<ReminderEntity>)?.count ?? 0
                                        )
                                            .foregroundStyle(Color.black)
                                            .addSwipeAction(edge: .trailing) {
                                                Button {
                                                    addListSheetViewModel.deleteList(item: list)
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
