import SwiftUI
import SwipeActions

struct HomeView: View {
    @State private var isNewReminderSheetPresented = false
    @State private var isAddListSheetPresented = false
    
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
                        
                        Text("My Lists")
                            .font(.system(size: 22, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 15)
                            .padding(.bottom, 10)
                        
                        LazyVStack(spacing: 0) {
                            ForEach(0 ..< 25) { _ in
                                NavigationLink {
                                    
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
                    
                    HStack {
                        Button {
                            isNewReminderSheetPresented = true
                        } label: {
                            HStack(spacing: 10) {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 24, height: 24)
                                    .overlay {
                                        Image(systemName: "plus")
                                            .foregroundStyle(Color.white)
                                            .fontWeight(.semibold)
                                    }
                                
                                Text("New Reminder")
                                    .font(.system(size: 18, weight: .semibold))
                            }
                        }
                        .sheet(isPresented: $isNewReminderSheetPresented) {
                            Text("New reminder sheet")
                        }
                        
                        Spacer()
                        
                        Button {
                            isAddListSheetPresented = true
                        } label: {
                            Text("Add List")
                                .font(.system(size: 18))
                        }
                        .sheet(isPresented: $isAddListSheetPresented) {
                            Text("Add list sheet")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .background(Colors.background)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
