import SwiftUI

struct AddListSheetViewIconSelection: View {
    @Binding var selectedIcon: String
    
    let iconColumns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 6)
    
    var body: some View {
        LazyVGrid(columns: iconColumns, spacing: 0) {
            ForEach(NewListData.icons, id: \.self) { icon in
                Circle()
                    .fill(Colors.gray30)
                    .frame(width: 36, height: 36)
                    .overlay {
                        Group {
                            if selectedIcon == icon {
                                Circle()
                                    .stroke(Colors.gray50, lineWidth: 3)
                                    .frame(width: 48, height: 48)
                            }
                            
                            Image(systemName: icon)
                                .foregroundStyle(Colors.gray90)
                                .imageScale(.medium)
                        }
                    }
                    .padding()
                    .onTapGesture {
                        selectedIcon = icon
                    }
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    AddListSheetViewIconSelection(selectedIcon: .constant("list.bullet"))
}
