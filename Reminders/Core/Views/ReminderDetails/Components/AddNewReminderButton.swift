import SwiftUI

struct AddNewReminderButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    AddNewReminderButton(action: {})
}
