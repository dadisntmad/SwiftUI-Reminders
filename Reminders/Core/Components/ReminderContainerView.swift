import SwiftUI

struct ReminderContainerView: View {
    let imagePath: String?
    let count: Int?
    let title: String
    let circleFillColor: Color
    let isSystemImage: Bool
    let isDateCircle: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .fill(circleFillColor)
                    .frame(width: 32, height: 32)
                    .overlay {
                        if isDateCircle {
                            Text(Date.now, format: .dateTime.day())
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.white)
                            
                        } else {
                            if let imagePath = imagePath {
                                Group {
                                    if isSystemImage {
                                        Image(systemName: imagePath)
                                            .resizable()
                                    } else {
                                        Image(imagePath)
                                            .resizable()
                                    }
                                }
                                .foregroundStyle(.white)
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                            }
                        }
                    }
                
                Spacer()
                
                if let count = count {
                    Text("\(count)")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundStyle(Color.black)
                }
            }
            
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Colors.gray70)
        }
        .padding(.horizontal, 12)
        .frame(width: 164, height: 82)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ReminderContainerView(imagePath: nil, count: 3, title: "Today", circleFillColor: Color.blue, isSystemImage: false, isDateCircle: true)
}
