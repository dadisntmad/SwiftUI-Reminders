import SwiftUI

struct KeyboardToolbarView: View {
    @Binding var selectedDateBox: Int
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0 ..< 4) { index in
                KeyboardDateSelectionView(calendarText: "11", title: "Today", isSelected: selectedDateBox == index)
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
