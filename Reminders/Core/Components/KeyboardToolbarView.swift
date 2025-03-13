import SwiftUI

struct KeyboardToolbarView: View {
    @Binding var selectedDateBox: Int
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0 ..< 4) { index in
                KeyboardDateSelectionView(
                    isSelected: selectedDateBox == index,
                    index: index
                )
                    .onTapGesture {
                        selectedDateBox = index
                    }
            }
        }
    }
}

#Preview {
    KeyboardToolbarView(selectedDateBox: .constant(0))
}
