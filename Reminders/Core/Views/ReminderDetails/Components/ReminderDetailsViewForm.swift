import SwiftUI

struct ReminderDetailsViewForm: View {
    let resetTimer: () -> Void
    
    @Binding var isSelected: Bool
    @Binding var title: String
    @Binding var subtitle: String
    
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
                
                TextField("New Reminder", text: $title, axis: .vertical)
                    .onChange(of: title, initial: false) { _, _ in
                        resetTimer()
                    }
                
            }
            .padding(.horizontal)
            
            TextField("Add Note", text: $subtitle, axis: .vertical)
                .foregroundStyle(Colors.gray70)
                .font(.system(size: 15))
                .padding(.horizontal, 46)
                .onChange(of: subtitle, initial: false) { _, _ in
                    resetTimer()
                }
            
            Divider()
                .padding(.leading, 46)
        }
    }
}

#Preview {
    ReminderDetailsViewForm(resetTimer: {}, isSelected: .constant(false), title: .constant("Title"), subtitle: .constant("Subtitle"))
}
