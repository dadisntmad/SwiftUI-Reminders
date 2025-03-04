import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()
            
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
