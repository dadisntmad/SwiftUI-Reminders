import SwiftUI

struct AddListSheetView: View {
    @State private var listName = ""
    @State private var isDialogPresented = false
    @State private var selectedColor = Color.blue
    @State private var selectedIcon: String
    
    let colorColumns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    let iconColumns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 6)
    
    @Environment(\.dismiss) private var dismiss
    
    private var shouldShowDialog: Bool {
        let isNotEmpty = !listName.trimmingCharacters(in: .whitespaces).isEmpty
        
        return isNotEmpty
    }
    
    private var isEmpty: Bool {
        return listName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    init() {
        _selectedIcon = State(initialValue: NewListData.icons[0])
    }
    
    var body: some View {
        VStack {
            // buttons
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
            
            Spacer()
            
            ScrollView(showsIndicators: false) {
                // form
                VStack {
                    VStack {
                        Circle()
                            .fill(selectedColor)
                            .frame(width: 96, height: 96)
                            .padding()
                            .overlay {
                                Image(systemName: selectedIcon)
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: 48))
                            }
                        
                        ZStack(alignment: .trailing) {
                            TextField("List Name", text: $listName)
                                .foregroundStyle(selectedColor)
                                .font(.system(size: 22, weight: .bold))
                                .frame(height: 56)
                                .padding(.horizontal)
                                .padding(.trailing, 28)
                                .background(Colors.gray30)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            if !isEmpty {
                                Circle()
                                    .fill(Colors.gray50)
                                    .frame(width: 22, height: 22)
                                    .padding(.horizontal)
                                    .overlay {
                                        Image(systemName: "xmark")
                                            .foregroundStyle(Color.white)
                                            .imageScale(.small)
                                    }
                                    .onTapGesture {
                                        listName = ""
                                    }
                            }
                        }
                    }
                    .padding()
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // colors
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
                
                // icons
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
            .padding()
        }
        .background(Colors.background)
    }
}

#Preview {
    AddListSheetView()
}
