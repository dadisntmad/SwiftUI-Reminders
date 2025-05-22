import SwiftUI

struct ReminderDetailsViewForm: View {
    let reminder: ReminderEntity?
    let isEditing: Bool
    let isFormPresented: Bool
    let list: ReminderListEntity?
    
    @State private var isSelected = false
    @State private var title = ""
    @State private var subtitle = ""
    
    @State private var isDateDialogPresented = false
    @State private var date = Date()
    @State private var time = Date()
    
    
    @State private var workItem: DispatchWorkItem?
    
    @State private var reminderDetailsViewModel = ReminderDetailsViewModel()
    @State private var newReminderViewModel = NewReminderViewModel()
    
    @Binding var isFormPresentedState: Bool
    @Binding var isEditingState: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Circle()
                    .fill(isSelected ? Color.blue : Color.clear)
                    .frame(width: 16, height: 16)
                    .overlay {
                        Circle()
                            .stroke(isSelected ? Color.blue : Colors.gray70, lineWidth: 2)
                            .frame(width: 22, height: 22)
                    }
                    .onTapGesture {
                        isSelected.toggle()
                    }
                    .onChange(of: isSelected, initial: false) { _, _ in
                        resetTimer()
                    }
                
                if isEditing {
                    TextField("New Reminder", text: $title, axis: .vertical)
                        .onChange(of: title, initial: false) { _, _ in
                            resetTimer()
                        }
                } else if isFormPresented {
                    TextField("New Reminder", text: $title, axis: .vertical)
                        .onChange(of: title, initial: false) { _, _ in
                            resetTimer()
                        }
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Button("Choose Date") {
                                    isDateDialogPresented = true
                                }
                            }
                        }
                    
                } else {
                    Text(reminder?.title ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal)
            
            if isEditing {
                TextField("Add Note", text: $subtitle, axis: .vertical)
                    .foregroundStyle(Colors.gray70)
                    .font(.system(size: 15))
                    .padding(.horizontal, 42)
                    .onChange(of: subtitle, initial: false) { _, _ in
                        resetTimer()
                    }
                
            } else if isFormPresented {
                TextField("Add Note", text: $subtitle, axis: .vertical)
                    .foregroundStyle(Colors.gray70)
                    .font(.system(size: 15))
                    .padding(.horizontal, 42)
                    .onChange(of: subtitle, initial: false) { _, _ in
                        resetTimer()
                    }
            } else {
                Text(reminder?.notes ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 42)
            }
            
            Divider()
                .padding(.leading, 42)
        }
        .task {
            if title.isEmpty { title = reminder?.title ?? "" }
            if subtitle.isEmpty { subtitle = reminder?.notes ?? "" }
            isSelected = reminder?.isCompleted ?? false
        }
        .sheet(isPresented: $isDateDialogPresented) {
            DateDialogView(date: $date, time: $time)
        }
        
    }
    
    private func resetTimer() {
        workItem?.cancel()
        
        let task = DispatchWorkItem {
            
            if isEditing {
                guard let reminder = reminder else { return }
                isEditingState = false
                reminderDetailsViewModel.editReminder(
                    reminder: reminder,
                    newTitle: title,
                    newNotes: subtitle,
                    newIsCompleted: isSelected
                )
                
                if isSelected {
                    reminderDetailsViewModel.cancelNotification(reminderId: reminder.reminderId ?? "")
                }
            } else {
                guard let list = list else { return }
                isFormPresentedState = false
                
                Task {
                    await newReminderViewModel.addReminder(
                        title: title,
                        notes: subtitle,
                        remindAt: Dates.remindAtDate(date: date, time: time),
                        to: list
                    )
                }
            }
        }
        
        workItem = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: task)
    }
}


#Preview {
    ReminderDetailsViewForm(
        reminder: nil,
        isEditing: false,
        isFormPresented: false,
        list: ReminderListEntity(),
        isFormPresentedState: .constant(false),
        isEditingState: .constant(false)
    )
}
