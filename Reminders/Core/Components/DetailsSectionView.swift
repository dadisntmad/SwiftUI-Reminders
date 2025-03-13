
import SwiftUI

struct DetailsSectionView: View {
    let index: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Details")
                    .font(.system(size: 17))
                
                Text("Test")
                    .foregroundStyle(Colors.gray50)
                    .font(.system(size: 15))
            }
            
            Spacer()
            
            Image("caret")
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    DetailsSectionView(index: 0)
}
