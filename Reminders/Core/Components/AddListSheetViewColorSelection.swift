import SwiftUI

struct AddListSheetViewColorSelection: View {
    @Binding var selectedColor: Color
    
    let colorColumns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 6)
    
    var body: some View {
        LazyVGrid(columns: colorColumns, spacing: 0) {
            ForEach(NewListData.colors, id: \.self) { color in
                Circle()
                    .fill(color)
                    .frame(width: 40, height: 40)
                    .padding()
                    .overlay(
                        Group {
                            if selectedColor == color {
                                Circle()
                                    .stroke(Colors.gray50, lineWidth: 3)
                                    .frame(width: 48, height: 48)
                            }
                        }
                    )
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.vertical, 15)
    }
}

#Preview {
    AddListSheetViewColorSelection(selectedColor: .constant(Color.blue))
}
