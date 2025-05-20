import SwiftUI

struct ReminderDetailsViewForm: View {
    let reminder: ReminderEntity?
    let isEditing: Bool

    @State private var isSelected = false
    @State private var title = ""
    @State private var subtitle = ""
    
    
    @State private var workItem: DispatchWorkItem?

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

                if isEditing {
                    TextField("New Reminder", text: $title, axis: .vertical)
                        .onChange(of: title, initial: false) { _, _ in
                            resetTimer()
                        }
                        .onAppear {
                            title = reminder?.title ?? ""
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
                    .onAppear {
                        subtitle = reminder?.notes ?? ""
                    }
            } else {
                Text(reminder?.notes ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 42)
            }

            Divider()
                .padding(.leading, 42)
        }
    }
    
        private func resetTimer() {
            workItem?.cancel()
    
            let task = DispatchWorkItem {
                if !title.isEmpty {
                    // append reminder
                }
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
