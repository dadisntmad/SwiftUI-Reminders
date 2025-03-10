import SwiftUI

struct UserListView: View {
    let circleColor: Color
    let imagePath: String
    let listTitle: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                HStack(spacing: 12) {
                    Circle()
                        .fill(circleColor)
                        .frame(width: 32, height: 32)
                        .overlay {
                            Image(systemName: imagePath)
                                .foregroundStyle(Color.white)
                                .imageScale(.small)
                        }
                    
                    Text(listTitle)
                        .font(.system(size: 17))
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundStyle(Color.blue)
                }
            }
        }
        .tint(Color.black)
    }
}

#Preview {
    UserListView(circleColor: .orange, imagePath: "list.bullet", listTitle: "Reminder", isSelected: false, action: {})
}
