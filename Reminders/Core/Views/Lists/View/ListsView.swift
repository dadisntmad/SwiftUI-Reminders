
import SwiftUI

struct ListsView: View {
    @Binding var selectedList: Int
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Reminder will be created Reminder")
                .bold()
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(0 ..< 5) { index in
                        UserListView(
                            circleColor: Color.orange,
                            imagePath: "list.bullet",
                            listTitle: "Reminder",
                            isSelected: selectedList == index) {
                                if selectedList == index {
                                    dismiss()
                                    return
                                }
                                
                                selectedList = index
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
    ListsView(selectedList: .constant(1))
}
