import SwiftUI

struct ListContainerView: View {
    let circleColor: Color
    let title: String
    let imagePath: String
    let count: Int
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                Circle()
                    .fill(circleColor)
                    .frame(width: 32, height: 32)
                    .overlay {
                        Image(systemName: imagePath)
                            .imageScale(.small)
                            .foregroundStyle(Color.white)
                    }
                
                Text(title)
                    .font(.system(size: 17))
            }
            
            Spacer()
            
            HStack(spacing: 6) {
                if count > 0 {
                    Text(String(count))
                        .font(.system(size: 17))
                        .foregroundStyle(Colors.gray70)
                }
                
                Image("caret")
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 54)
        .background(Color.white)
    }
}

#Preview {
    ListContainerView(circleColor: .orange, title: "Reminder", imagePath: "list.bullet", count: 1)
}
