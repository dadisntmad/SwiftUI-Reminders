import SwiftUI

struct AddListSheetViewForm: View {
    let selectedColor: Color
    let selectedIcon: String
    let isEmpty: Bool
    
    @Binding var listName: String
    
    var body: some View {
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
    }
}

#Preview {
    AddListSheetViewForm(selectedColor: Color.blue, selectedIcon: "list.bullet", isEmpty: false, listName: .constant("Test List"))
}
