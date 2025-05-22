import SwiftUI

struct ReminderDetailsView: View {
    @State private var isFormPresented = false
    @State private var isEditing = false
    @State private var selectedReminder: ReminderEntity?
    
    @State private var homeViewModel = HomeViewModel()
    @State private var newReminderViewModel = NewReminderViewModel()
    
    var list: ReminderListEntity
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    let reminders = homeViewModel.specificListReminders(for: list)
                    
                    ForEach(reminders) { reminder in
                        ReminderDetailsViewForm(
                            reminder: reminder,
                            isEditing: isEditing,
                            isFormPresented: false,
                            list: nil,
                            isFormPresentedState: $isFormPresented,
                            isEditingState: $isEditing
                        )
                        .onTapGesture {
                            isEditing = true
                        }
                    }
                }

                if isFormPresented {
                    ReminderDetailsViewForm(
                        reminder: nil,
                        isEditing: false,
                        isFormPresented: true,
                        list: list,
                        isFormPresentedState: $isFormPresented,
                        isEditingState: $isEditing
                    )
                }
            }
            .onTapGesture {
                isFormPresented = true
            }
            
            AddNewReminderButton {
                isFormPresented = true
            }
        }
    }
}

#Preview {
    ReminderDetailsView(list: ReminderListEntity())
}
