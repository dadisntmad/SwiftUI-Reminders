import SwiftUI

struct ActionButtons: View {
    @State private var isNewReminderSheetPresented = false
    @State private var isAddListSheetPresented = false
    
    var body: some View {
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

#Preview {
    ActionButtons()
}
