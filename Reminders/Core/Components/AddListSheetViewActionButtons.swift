import SwiftUI

struct AddListSheetViewActionButtons: View {
    let isEmpty: Bool
    
    @Binding var isDialogPresented: Bool
    @Binding var listName: String
    
    @Environment(\.dismiss) private var dismiss
    
    private var shouldShowDialog: Bool {
        let isNotEmpty = !listName.trimmingCharacters(in: .whitespaces).isEmpty
        
        return isNotEmpty
    }
    
    var body: some View {
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
                    listName = ""
                }
            }
            
            Spacer()
            
            Text("New List")
                .font(.system(size: 17, weight: .semibold))
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Add")
            }
            .disabled(isEmpty)
        }
        .padding()
    }
}

#Preview {
    AddListSheetViewActionButtons(isEmpty: false, isDialogPresented: .constant(false), listName: .constant("List Name"))
}
