import SwiftUI

struct ReminderDetailsViewForm: View {
    let reminder: ReminderEntity?
    let isEditing: Bool
    
    @State private var isSelected = false
    @State private var title = ""
    @State private var subtitle = ""
    
    
    @State private var workItem: DispatchWorkItem?
    
    @State private var reminderDetailsViewModel = ReminderDetailsViewModel()
    
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
        
    }
    
    private func resetTimer() {
        workItem?.cancel()
        
        let task = DispatchWorkItem {
            guard let reminder = reminder else { return }
            reminderDetailsViewModel.editReminder(
                reminder: reminder,
                newTitle: title,
                newNotes: subtitle,
                newIsCompleted: isSelected
            )
        }
        
        workItem = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: task)
    }
}


#Preview {
    ReminderDetailsViewForm(
        reminder: nil,
        isEditing: false
    )
}
