import SwiftUI

struct ReminderDetailsView: View {
    @State private var title = ""
    @State private var subtitle = ""
    @State private var isFormPresented = true
    @State private var isFormDisabled = true
    @State private var isSelected = false
    
    @State private var reminders: [String] = []
    
    @State private var workItem: DispatchWorkItem?
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(reminders, id: \.self) { reminder in
                        ReminderDetailsViewForm(
                            resetTimer: resetTimer,
                            isSelected: $isSelected,
                            title: $title,
                            subtitle: $subtitle
                        )
                    }
                }
                
                if isFormPresented {
                    ReminderDetailsViewForm(
                        resetTimer: resetTimer,
                        isSelected: $isSelected,
                        title: $title,
                        subtitle: $subtitle
                    )
                }
            }
            .onTapGesture {
                isFormPresented.toggle()
            }
            
            AddNewReminderButton {
                // action
            }
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
    ReminderDetailsView()
}
