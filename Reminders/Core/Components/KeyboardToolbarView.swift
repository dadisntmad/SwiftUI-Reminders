import SwiftUI

struct KeyboardToolbarView: View {
    @Binding var selectedDateBox: Int
    @Binding var isDateDialogPresented: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0 ..< 4) { index in
                KeyboardDateSelectionView(
                    isSelected: selectedDateBox == index,
                    index: index
                )
                .onTapGesture {
                    selectedDateBox = index
                    
                    if selectedDateBox == 3 {
                        isDateDialogPresented = true
                    }
                }
            }
        }
    }
}

#Preview {
    KeyboardToolbarView(selectedDateBox: .constant(0), isDateDialogPresented: .constant(false))
}
