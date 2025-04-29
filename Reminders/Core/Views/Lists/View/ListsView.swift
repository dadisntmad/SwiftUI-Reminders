
import SwiftUI

struct ListsView: View {
    let title: String
    
    @Binding var selectedListIndex: Int
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var homeViewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            Text("Reminder will be created in \"\(title)\"")
                .bold()
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(Array(homeViewModel.lists.enumerated()), id: \.element.id) { index, list in
                        UserListView(
                            circleColor: Color.from(name: list.reminderColor ?? "orange"),
                            imagePath: list.reminderIcon ?? "list.bullet",
                            listTitle: list.reminderTitle ?? "Reminder",
                            isSelected: selectedListIndex == index
                        ) {
                            if selectedListIndex == index {
                                dismiss()
                                return
                            }
                            
                            selectedListIndex = index
                            dismiss()
                        }
                        
                        Divider()
                            .padding(.leading, 46)
                    }
                }
                .padding()
            }
            
            Spacer()
        }
    }
}

#Preview {
    ListsView(title: "Reminder", selectedListIndex: .constant(1))
}
