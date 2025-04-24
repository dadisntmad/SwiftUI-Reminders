import SwiftUI

struct AddListSheetView: View {
    @State private var listName = ""
    @State private var isDialogPresented = false
    @State private var selectedColor: Color
    @State private var selectedIcon: String
    
    private var isEmpty: Bool {
        return listName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    init() {
        _selectedColor = State(initialValue: NewListData.colors[0])
        _selectedIcon = State(initialValue: NewListData.icons[0])
    }
    
    var body: some View {
        VStack {
            // buttons
            AddListSheetViewActionButtons(
                isEmpty: isEmpty,
                isDialogPresented: $isDialogPresented,
                listName: $listName
            )
            
            Spacer()
            
            ScrollView(showsIndicators: false) {
                // form
                AddListSheetViewForm(
                    selectedColor: selectedColor,
                    selectedIcon: selectedIcon,
                    isEmpty: isEmpty,
                    listName: $listName
                )
                
                // colors
                AddListSheetViewColorSelection(selectedColor: $selectedColor)
                
                // icons
                AddListSheetViewIconSelection(selectedIcon: $selectedIcon)
            }
            .padding()
        }
        .background(Colors.background)
    }
}

#Preview {
    AddListSheetView()
}
