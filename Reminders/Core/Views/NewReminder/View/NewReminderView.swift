import SwiftUI

struct NewReminderView: View {
    @State private var title = ""
    @State private var notes = ""
    @State private var isDialogPresented = false
    @State private var selectedListIndex = 0
    @State private var selectedDateBox = 0
    @State private var isDateDialogPresented = false
    @State private var date = Date()
    @State private var time = Date()
    
    @State private var homeViewModel = HomeViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    private var isEmpty: Bool {
        return title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var shouldShowDialog: Bool {
        let titleIsNotEmpty = !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let notesIsNotEmpty = !notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        return titleIsNotEmpty || notesIsNotEmpty
    }
    
    private var selectedList: ReminderListEntity? {
        let lists = homeViewModel.lists
        
        guard lists.indices.contains(selectedListIndex) else { return nil }
        
        return lists[selectedListIndex]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Colors.background.ignoresSafeArea()
                
                VStack {
                    // action buttons
                    HStack {
                        Button {
                            if shouldShowDialog {
                                isDialogPresented = true
                            } else {
                                dismiss()
                            }
                        } label: {
                            Text("Cancel")
                        }
                        .confirmationDialog(
                            Text("Discard Changes?"),
                            isPresented: $isDialogPresented
                        ) {
                            Button("Discard Changes", role: .destructive) {
                                dismiss()
                                title = ""
                                notes = ""
                            }
                        }
                        
                        Spacer()
                        
                        Text("New Reminder")
                            .font(.system(size: 17, weight: .semibold))
                        
                        Spacer()
                        
                        Button {
                            homeViewModel.addReminder(
                                title: title,
                                notes: notes,
                                remindAt: Dates.remindAtDate(date: date, time: time),
                                to: selectedList ?? homeViewModel.lists[0]
                            )
                            
                            dismiss()
                        } label: {
                            Text("Add")
                        }
                        .disabled(isEmpty)
                    }
                    .padding()
                    
                    ScrollView(showsIndicators: false) {
                        // form
                        VStack(spacing: 16) {
                            CustomTextView(text: $title, selectedDateBox: $selectedDateBox, isDateDialogPresented: $isDateDialogPresented)
                                .padding(.horizontal)
                                .padding(.top)
                                .frame(minHeight: 44)
                                .sheet(isPresented: $isDateDialogPresented) {
                                    DateDialogView(date: $date, time: $time)
                                }
                            
                            Divider()
                                .padding(.leading)
                            
                            ZStack(alignment: .topLeading) {
                                TextEditor(text: $notes)
                                    .frame(minHeight: 100)
                                    .padding(.horizontal)
                                
                                if notes.isEmpty {
                                    Text("Notes")
                                        .foregroundColor(.gray50)
                                        .padding(.horizontal)
                                        .padding(.top, 8)
                                }
                            }
                            
                            Spacer()
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.bottom, 15)
                        
                        // details
                        DetailsSectionView(
                            index: selectedDateBox,
                            date: date,
                            time: time
                        )
                        .padding(.bottom, 15)
                        
                        // list
                        NavigationLink {
                            ListsView(
                                title: selectedList?.reminderTitle ?? "Reminder",
                                selectedListIndex: $selectedListIndex
                            )
                            .navigationTitle("List")
                        } label: {
                            HStack(spacing: 6) {
                                Text("List")
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 17))
                                
                                Spacer()
                                
                                HStack {
                                    Circle()
                                        .fill(Color.from(name: selectedList?.reminderColor ?? "orange"))
                                        .frame(width: 8, height: 8)
                                    
                                    Text(selectedList?.reminderTitle ?? "")
                                        .font(.system(size: 17))
                                        .foregroundStyle(Color.gray70)
                                    
                                    Image("caret")
                                }
                            }
                            .padding(.horizontal)
                            .frame(height: 54)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    NewReminderView()
}
