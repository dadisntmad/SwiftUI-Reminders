import SwiftUI

struct MyListsTextView: View {
    var body: some View {
        Text("My Lists")
            .font(.system(size: 22, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 15)
            .padding(.bottom, 10)
    }
}

#Preview {
    MyListsTextView()
}
